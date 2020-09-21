import 'package:aker_foods_retail/data/models/coupon_model.dart';

// ignore: one_member_abstracts
abstract class CartRepository {
  Future<List<CouponModel>> getPromoCodes();
}
