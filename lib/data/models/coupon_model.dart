import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  CouponModel({
    String code,
    String description,
    double minimumCartValue,
    DiscountModel discount,
  }) : super(
          code: code,
          description: description,
          minimumCartValue: minimumCartValue,
          discount: discount,
        );

  // ignore: prefer_constructors_over_static_methods
  static CouponModel fromJson(Map<String, dynamic> jsonMap) => CouponModel(
        code: jsonMap['code'],
        description: jsonMap['description'],
        minimumCartValue: jsonMap['minimum_cart_val'],
        discount: DiscountModel.fromJson(jsonMap),
      );
}

class DiscountModel extends DiscountEntity {
  DiscountModel({
    double value,
    bool isPercentage,
  }) : super(
          value: value,
          isPercentage: isPercentage,
        );

  // ignore: prefer_constructors_over_static_methods
  static DiscountModel fromJson(Map<String, dynamic> jsonMap) => DiscountModel(
        value: jsonMap['value'],
        isPercentage: jsonMap['is_percentage'],
      );
}
