import 'dart:async';

import 'package:aker_foods_retail/common/constants/payment_constants.dart';
import 'package:aker_foods_retail/common/exceptions/cart_data_exception.dart';
import 'package:aker_foods_retail/common/exceptions/server_exception.dart';
import 'package:aker_foods_retail/data/models/razorpay_payment_model.dart';
import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';
import 'package:aker_foods_retail/domain/entities/payment_details_entity.dart';
import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/products_use_case.dart';
import 'package:aker_foods_retail/domain/usecases/user_order_use_case.dart';
import 'package:aker_foods_retail/network/http/http_util.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final LoaderBloc loaderBloc;
  final SnackBarBloc snackBarBloc;
  final CartUseCase cartUseCase;
  final ProductsUseCase productsUseCase;
  final UserOrderUseCase userOrderUseCase;

  static const int _orderPaymentVerificationPollingInterval = 10;
  int _verifyOrderPaymentPollingRemainingSeconds = 10 * 30; // 300 seconds
  Timer _orderPaymentVerificationPollingTimer;

  int _cartId;

  CartBloc({
    this.loaderBloc,
    this.snackBarBloc,
    this.cartUseCase,
    this.productsUseCase,
    this.userOrderUseCase,
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
    } else if (event is ApplyPromoCodeToCartEvent) {
      yield* _processApplyPromoCodeToCartEvent(event);
    } else if (event is RemovePromoCodeFromCartEvent) {
      yield* _processRemovePromoCodeFromCartEvent();
    } else if (event is ChangePaymentModeEvent) {
      yield* _processChangePaymentModeEvent(event);
    } else if (event is CreateOrderCartEvent) {
      yield* _processCreateOrderCartEvent(event);
    } else if (event is NotifyUserAboutProductEvent) {
      yield* _handleNotifyUserAboutProductEvent(event);
    }

    if (event is CartOrderVerifyPaymentEvent) {
      yield* _processCartOrderVerifyPaymentEvent(event);
    } else if (event is CartOrderPaymentSuccessEvent) {
      yield* _processCartOrderPaymentSuccessEvent(event);
    } else if (event is CartOrderPaymentFailedEvent) {
      yield* _processCartOrderPaymentFailedEvent(event);
    }
  }

  Future<void> _timerCallback() async {
    try {
      final paymentIsVerified =
          await userOrderUseCase.verifyTransactionForOrder(_cartId);
      if (paymentIsVerified) {
        _orderPaymentVerificationPollingTimer.cancel();
        loaderBloc.add(DismissLoaderEvent());
        add(CartOrderPaymentSuccessEvent());
        snackBarBloc.add(ShowSnackBarEvent(
          type: CustomSnackBarType.success,
          text: 'Payment successful : $_cartId',
        ));
        return;
      }
    } catch (_) {}
    _verifyOrderPaymentPollingRemainingSeconds -= 10;
    if (_verifyOrderPaymentPollingRemainingSeconds > 0) {
      _startTimer();
    } else {
      _orderPaymentVerificationPollingTimer.cancel();
      loaderBloc.add(DismissLoaderEvent());
      add(CartOrderPaymentFailedEvent());
      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: 'Failed to verify the order payment. '
            'Please visit order details for more information.',
      ));
    }
  }

  void _startTimer() {
    /// NOTE: Run timer for max 300 seconds
    _orderPaymentVerificationPollingTimer = Timer(
      const Duration(seconds: _orderPaymentVerificationPollingInterval),
      _timerCallback,
    );
  }

  Stream<CartState> _processCartOrderVerifyPaymentEvent(
      CartOrderVerifyPaymentEvent event) async* {
    _startTimer();
  }

  Stream<CartState> _processCartOrderPaymentSuccessEvent(
      CartOrderPaymentSuccessEvent event) async* {
    await cartUseCase.clearCart();
    yield NavigatedToOrderListState();
  }

  Stream<CartState> _processCartOrderPaymentFailedEvent(
      CartOrderPaymentFailedEvent event) async* {
    await cartUseCase.clearCart();
    yield NavigatedToOrderListState();
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

  Stream<CartState> _processError(
      dynamic error, CartEntity cartEntity, Map<int, int> idCountMap) async* {
    if (error is CartDataException) {
      if (error.hasOutOfStockProducts ?? false) {
        for (final cartProduct in cartEntity.products) {
          final idString = '${cartProduct?.product?.id}';
          if (error.outOfStockProductIds.contains(idString)) {
            cartProduct?.product?.isInStock = false;
          }
        }
      }
      yield CartLoadedState(
        hasInvalidPromoCodeApplied: error.hasInvalidPromoCodeApplied,
        hasOutOfStockProducts: error.hasOutOfStockProducts,
        message: error.message,
        cartEntity: cartEntity,
        productIdCountMap: idCountMap,
      );

      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: error.message,
      ));
      return;
    }

    String message = '${HttpUtil.unknownError}: ${error.toString()}';
    if (error is ServerException) {
      message = error.message;
    }
    yield CartLoadedState(
      cartEntity: cartEntity,
      productIdCountMap: idCountMap,
    );
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: message,
    ));
  }

  /*Stream<CartState> _cartLoadingState() async* {
    CartLoadedState _cartLoadedState;
    if (state is CartLoadedState) {
      _cartLoadedState = state;
    }
    yield CartLoadingState(
      cartEntity: state.cartEntity,
      productIdCountMap: _productIdCountMap(state.cartEntity),
      hasOutOfStockProducts: _cartLoadedState?.hasOutOfStockProducts,
      message: _cartLoadedState?.message,
    );
  }*/

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
    //yield* _cartLoadingState();
    final CartEntity cartEntity = await cartUseCase.getCartData();
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    try {
      if (idCountMap.isNotEmpty) {
        yield CartLoadingState(totalProductCount: state.totalProductCount);
        //yield* _cartLoadingState();
        cartEntity.billingEntity = await _validateCart(cartEntity);
      } else if (idCountMap.isEmpty) {
        yield CartEmptyState();
        return;
      }
      yield CartLoadedState(
        cartEntity: cartEntity,
        productIdCountMap: idCountMap,
      );
    } catch (error) {
      yield* _processError(error, cartEntity, idCountMap);
    }
  }

  Stream<CartState> _processAddProductToCartEvent(
      AddProductToCartEvent event) async* {
    final cartEntity = await cartUseCase.addProduct(event.productEntity);
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    try {
      if (event.needsCartValidation && idCountMap.isNotEmpty) {
        yield CartLoadingState(totalProductCount: state.totalProductCount);
        //yield* _cartLoadingState();
        cartEntity.billingEntity = await _validateCart(cartEntity);
      } else if (idCountMap.isEmpty) {
        yield CartEmptyState();
        return;
      }
      yield CartProductUpdatedState(
        cartEntity: cartEntity,
        productIdCountMap: idCountMap,
      );
    } catch (error) {
      yield* _processError(error, cartEntity, idCountMap);
    }
  }

  Stream<CartState> _processRemoveProductFromCartEvent(
      RemoveProductFromCartEvent event) async* {
    final cartEntity = await cartUseCase.removeProduct(event.productEntity);
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    try {
      if (event.needsCartValidation && idCountMap.isNotEmpty) {
        yield CartLoadingState(totalProductCount: state.totalProductCount);
        //yield* _cartLoadingState();
        cartEntity.billingEntity = await _validateCart(cartEntity);
      } else if (idCountMap.isEmpty) {
        yield CartEmptyState();
        return;
      }
      yield CartProductUpdatedState(
        cartEntity: cartEntity,
        productIdCountMap: idCountMap,
      );
    } catch (error) {
      yield* _processError(error, cartEntity, idCountMap);
    }
  }

  Stream<CartState> _processCreateOrderCartEvent(
      CreateOrderCartEvent event) async* {
    loaderBloc.add(ShowLoaderEvent());
    final cartEntity = await cartUseCase.getCartData();
    try {
      cartEntity.billingEntity = state.cartEntity?.billingEntity;
      final createOrderResponse = await cartUseCase.createOrder(
        event.paymentModeInt,
        event.selectedAddressId,
        cartEntity,
      );

      _cartId = createOrderResponse.id;
      if (event.paymentModeInt == PaymentModeConstants.online) {
        _initiateRazorPayTransaction(createOrderResponse.paymentDetails);
      } else {
        await cartUseCase.clearCart();
        yield NavigatedToOrderListState();
        loaderBloc.add(DismissLoaderEvent());
        snackBarBloc.add(ShowSnackBarEvent(
          type: CustomSnackBarType.success,
          text: 'Order placed successfully',
        ));
      }
    } catch (error) {
      loaderBloc.add(DismissLoaderEvent());
      yield* _processError(error, cartEntity, _productIdCountMap(cartEntity));
    }
  }

  void _initiateRazorPayTransaction(PaymentDetailsEntity paymentDetails) {
    final razorpayPaymentModel =
        RazorpayPaymentModel.fromPaymentDetails(paymentDetails);
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
    debugPrint('Razorpay PaymentSuccess => ${response.orderId}');
    add(CartOrderVerifyPaymentEvent(cartId: _cartId));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint('${response.message}');
    loaderBloc.add(DismissLoaderEvent());
    add(CartOrderPaymentFailedEvent());
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: 'Payment error: ${response.message}',
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('Wallet payment callback');
    loaderBloc.add(DismissLoaderEvent());
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: 'Currently wallet payments are not supported',
    ));
  }

  Stream<CartState> _handleNotifyUserAboutProductEvent(
      NotifyUserAboutProductEvent event) async* {
    loaderBloc.add(ShowLoaderEvent());
    final productId = event.productEntity.id;
    final status = await productsUseCase.notifyUserForProduct(productId);
    if (status) {
      if (event.needsCartValidation ?? false) {
        final cartEntity = await cartUseCase.getCartData();
        cartEntity.products.removeWhere(
          (cartProduct) => cartProduct?.product?.id == productId,
        );
        await cartUseCase.saveCart(cartEntity);
        final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
        if (idCountMap.isNotEmpty) {
          yield CartLoadingState(totalProductCount: state.totalProductCount);
          //yield* _cartLoadingState();
          cartEntity.billingEntity = await _validateCart(cartEntity);
        } else {
          yield CartEmptyState();
          return;
        }
        yield CartLoadedState(
          cartEntity: cartEntity,
          productIdCountMap: idCountMap,
        );
      }
      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.success,
        text: 'You will be notified when the product is back in stock',
      ));
    } else {
      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: 'We are unable to process your request, please try later',
      ));
    }
    loaderBloc.add(DismissLoaderEvent());
  }

  Stream<CartState> _processApplyPromoCodeToCartEvent(
      ApplyPromoCodeToCartEvent event) async* {
    yield CartLoadingState(totalProductCount: state.totalProductCount);
    CartEntity cartEntity = await cartUseCase.getCartData();
    cartEntity.promoCode = event.promoCode;
    cartEntity = await cartUseCase.saveCart(cartEntity);
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    try {
      cartEntity.billingEntity = await _validateCart(cartEntity);
      yield CartLoadedState(
        cartEntity: cartEntity,
        productIdCountMap: idCountMap,
      );
    } catch (error) {
      yield* _processError(error, cartEntity, idCountMap);
    }
  }

  Stream<CartState> _processRemovePromoCodeFromCartEvent() async* {
    yield CartLoadingState(totalProductCount: state.totalProductCount);
    CartEntity cartEntity = await cartUseCase.getCartData();
    cartEntity.promoCode = null;
    cartEntity = await cartUseCase.saveCart(cartEntity);
    final Map<int, int> idCountMap = _productIdCountMap(cartEntity);
    try {
      cartEntity.billingEntity = await _validateCart(cartEntity);
      yield CartLoadedState(
        cartEntity: cartEntity,
        productIdCountMap: idCountMap,
      );
    } catch (error) {
      yield* _processError(error, cartEntity, idCountMap);
    }
  }

  Stream<CartState> _processChangePaymentModeEvent(
      ChangePaymentModeEvent event) async* {
    loaderBloc.add(ShowLoaderEvent());
    final CartEntity cartEntity = await cartUseCase.getCartData();
    cartEntity.paymentMode = event.selectedModeInt;
    await cartUseCase.saveCart(cartEntity);
    loaderBloc.add(DismissLoaderEvent());
  }
}
