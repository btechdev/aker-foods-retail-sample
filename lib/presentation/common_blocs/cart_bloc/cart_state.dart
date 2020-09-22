import 'package:flutter/foundation.dart';

abstract class CartState {
  final int totalProductCount;

  CartState({@required this.totalProductCount});
}

class CartInitialState extends CartState {
  CartInitialState() : super(totalProductCount: 0);
}

class CartLoadedState extends CartState {
  final Map<int, int> productIdCountMap;

  CartLoadedState({
    this.productIdCountMap,
  }) : super(totalProductCount: productIdCountMap.length);
}

class CartProductUpdatedState extends CartLoadedState {
  CartProductUpdatedState({
    Map<int, int> productIdCountMap,
  }) : super(productIdCountMap: productIdCountMap);
}

class CartPromoCodeUpdatedState extends CartLoadedState {
  CartPromoCodeUpdatedState({
    Map<int, int> productIdCountMap,
  }) : super(productIdCountMap: productIdCountMap);
}
