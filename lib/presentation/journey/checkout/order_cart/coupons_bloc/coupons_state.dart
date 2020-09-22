import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';

abstract class CouponsState {}

class CouponsInitialState extends CouponsState {}

class CouponsFetchingState extends CouponsState {}

class CouponsFetchSuccessState extends CouponsState {
  final List<CouponEntity> coupons;

  CouponsFetchSuccessState({this.coupons});
}

class CouponsFetchFailedState extends CouponsState {}
