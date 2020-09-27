import 'package:aker_foods_retail/common/constants/payment_constants.dart';
import 'package:aker_foods_retail/data/models/razorpay_payment_model.dart';
import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';
import 'package:aker_foods_retail/domain/entities/payment_details_entity.dart';
import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final SnackBarBloc snackBarBloc;
  final CartUseCase cartUseCase;

  CartBloc({
    this.snackBarBloc,
    this.cartUseCase,
  }) : super(CartInitialState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartEvent) {
      yield* _processLoadCartEvent(event);
    } else if (event is ValidateCartEvent) {
      yield* _processValidateCartEvent(event);
    } else if (event is AddProductToCartEvent) {
      yield* _processAddProductToCartEvent(event);
    } else if (event is RemoveProductFromCartEvent) {
      yield* _processRemoveProductFromCartEvent(event);
    } else if (event is CreateOrderCartEvent) {
      yield* _processCreateOrderCartEvent(event);
    }
  }

  Map<int, int> _productIdCountMap(CartEntity cartEntity) {
    final Map<int, int> idCountMap = Map();
    for (final cartProductEntity in cartEntity.products) {
      idCountMap[cartProductEntity.product.id] = cartProductEntity.count;
    }
    return idCountMap;
  }

  Future<BillingEntity> _validateCart(CartEntity cartEntity) async {
    final billingEntity = await cartUseCase.validateCartPreCheckout(cartEntity);
    debugPrint('ValidateCartPreCheckout => ${billingEntity.toString()}');
    return billingEntity;
  }

  Stream<CartState> _processLoadCartEvent(LoadCartEvent event) async* {
    final cartEntity = await cartUseCase.getCartData();
    if (cartEntity?.products?.isEmpty == true) {
      yield CartEmptyState();
      return;
    }

    yield CartLoadedState(
      cartEntity: cartEntity,
      productIdCountMap: _productIdCountMap(cartEntity),
    );
  }

  Stream<CartState> _processValidateCartEvent(ValidateCartEvent event) async* {
    yield CartLoadingState(totalProductCount: state.totalProductCount);
    final CartEntity cartEntity = await cartUseCase.getCartData();
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    if (idCountMap.isNotEmpty) {
      yield CartLoadingState(totalProductCount: state.totalProductCount);
      cartEntity.billingEntity = await _validateCart(cartEntity);
    } else if (idCountMap.isEmpty) {
      yield CartEmptyState();
      return;
    }
    yield CartLoadedState(
      cartEntity: cartEntity,
      productIdCountMap: idCountMap,
    );
  }

  Stream<CartState> _processAddProductToCartEvent(
      AddProductToCartEvent event) async* {
    final cartEntity = await cartUseCase.addProduct(event.productEntity);
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    if (event.needsCartValidation && idCountMap.isNotEmpty) {
      yield CartLoadingState(totalProductCount: state.totalProductCount);
      cartEntity.billingEntity = await _validateCart(cartEntity);
    } else if (idCountMap.isEmpty) {
      yield CartEmptyState();
      return;
    }
    yield CartProductUpdatedState(
      cartEntity: cartEntity,
      productIdCountMap: idCountMap,
    );
  }

  Stream<CartState> _processRemoveProductFromCartEvent(
      RemoveProductFromCartEvent event) async* {
    final cartEntity = await cartUseCase.removeProduct(event.productEntity);
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    if (event.needsCartValidation && idCountMap.isNotEmpty) {
      yield CartLoadingState(totalProductCount: state.totalProductCount);
      cartEntity.billingEntity = await _validateCart(cartEntity);
    } else if (idCountMap.isEmpty) {
      yield CartEmptyState();
      return;
    }
    yield CartProductUpdatedState(
      cartEntity: cartEntity,
      productIdCountMap: idCountMap,
    );
  }

  Stream<CartState> _processCreateOrderCartEvent(
      CreateOrderCartEvent event) async* {
    debugPrint('********${event.paymentType}*********');
    yield CartLoadingState(totalProductCount: state.totalProductCount);
    final cartEntity = await cartUseCase.getCartData();
    final addressEntity = await cartUseCase.getSelectedAddress();
    cartEntity.billingEntity = state.cartEntity?.billingEntity;
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    final createOrderResponse = await cartUseCase.createOrder(
      event.paymentType,
      addressEntity.id,
      cartEntity,
    );

    if (event.paymentType == PaymentTypeConstants.online) {
      _initiateRazorPayTransaction(createOrderResponse.paymentDetails);
    }

    // TODO(Bhushan): Process order creation API response
    yield CartProductUpdatedState(
      cartEntity: cartEntity,
      productIdCountMap: idCountMap,
    );
  }

  void _initiateRazorPayTransaction(PaymentDetailsEntity paymentDetailsEntity) {
    final razorpayPaymentModel =
        RazorpayPaymentModel.fromPaymentDetails(paymentDetailsEntity);
    try {
      Razorpay()
        ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
        ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
        ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet)
        ..open(razorpayPaymentModel.toJson());
    } catch (e) {
      debugPrint(e.toString());
      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: 'Payment error: ${e.message}',
      ));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('${response.orderId}');
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.success,
      text: 'Payment success: ${response.orderId}',
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('${response.message}');
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: 'Payment error: ${response.message}',
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('success');
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: 'Balance added to wallet: ${response.walletName}',
    ));
  }
}
