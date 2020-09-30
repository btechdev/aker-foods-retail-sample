import 'package:aker_foods_retail/domain/entities/cart_entity.dart';
import 'package:flutter/foundation.dart';

abstract class CartState {
  final int totalProductCount;
  final CartEntity cartEntity;

  CartState({
    this.totalProductCount,
    this.cartEntity,
  });
}

class CartInitialState extends CartState {
  CartInitialState({
    int totalProductCount = 0,
  }) : super(
          totalProductCount: totalProductCount,
        );
}

class CartLoadingState extends CartState {
  CartLoadingState({
    int totalProductCount = 0,
  }) : super(
          totalProductCount: totalProductCount,
        );
}

class CartLoadedState extends CartState {
  final Map<int, int> productIdCountMap;
  final bool hasOutOfStockProducts;
  final String message;

  CartLoadedState({
    @required CartEntity cartEntity,
    @required this.productIdCountMap,
    this.hasOutOfStockProducts = false,
    this.message,
  }) : super(
          cartEntity: cartEntity,
          totalProductCount: productIdCountMap.length,
        );
}

class CartEmptyState extends CartState {
  CartEmptyState({
    int totalProductCount = 0,
  }) : super(
          totalProductCount: totalProductCount,
        );
}

class CartProductUpdatedState extends CartLoadedState {
  CartProductUpdatedState({
    @required CartEntity cartEntity,
    @required Map<int, int> productIdCountMap,
  }) : super(
          cartEntity: cartEntity,
          productIdCountMap: productIdCountMap,
        );
}

class CartPromoCodeUpdatedState extends CartLoadedState {
  CartPromoCodeUpdatedState({
    @required CartEntity cartEntity,
    @required Map<int, int> productIdCountMap,
  }) : super(
          cartEntity: cartEntity,
          productIdCountMap: productIdCountMap,
        );
}

class NotifyUserAboutProductSuccess extends CartState {}

class NotifyUserAboutProductFailure extends CartState {}
