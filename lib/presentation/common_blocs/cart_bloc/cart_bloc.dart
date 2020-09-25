import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';
import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc(this.cartUseCase) : super(CartInitialState());

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
}
