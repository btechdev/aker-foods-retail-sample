import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';

abstract class CartState {}

class CartEmptyState extends CartState {}

class CouponsFetchingState extends CartState {}

class CouponsFetchSuccessState extends CartState {
  final List<CouponEntity> coupons;

  CouponsFetchSuccessState({this.coupons});
}

class CouponsFetchFailedState extends CartState {}
