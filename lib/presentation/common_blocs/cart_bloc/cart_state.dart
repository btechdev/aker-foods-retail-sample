import 'dart:async';

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

class CartEmptyState extends CartState {
  CartEmptyState({
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

/*class CartLoadingState extends CartLoadedState {
  CartLoadingState({
    CartEntity cartEntity,
    Map<int, int> productIdCountMap,
    bool hasOutOfStockProducts,
    final String message,
  }) : super(
          cartEntity: cartEntity,
          productIdCountMap: productIdCountMap,
          hasOutOfStockProducts: hasOutOfStockProducts,
          message: message,
        );
}*/

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

class NavigatedToOrderListState extends CartState {
  final Timer timer;

  NavigatedToOrderListState({
    this.timer,
  }) : super(totalProductCount: 0);
}
