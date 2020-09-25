import 'package:aker_foods_retail/domain/entities/billing_entity.dart';

class BillingModel extends BillingEntity {
  BillingModel({
    final bool isCouponApplied,
    final double couponAmountSaved,
    final double totalAmount,
    final double discountedAmount,
    final double totalSaved,
    final int deliveryCharges,
  }) : super(
          isCouponApplied: isCouponApplied,
          couponAmountSaved: couponAmountSaved,
          totalAmount: totalAmount,
          discountedAmount: discountedAmount,
          totalSaved: totalSaved,
          deliveryCharges: deliveryCharges,
        );

  factory BillingModel.fromJson(Map<String, dynamic> jsonMap) => BillingModel(
        isCouponApplied: jsonMap['coupon']['is_applied'],
        couponAmountSaved: jsonMap['coupon']['amount_saved'],
        totalAmount: jsonMap['billing']['total_amount'],
        discountedAmount: jsonMap['billing']['discounted_amount'],
        totalSaved: jsonMap['billing']['total_saved'],
        deliveryCharges: jsonMap['billing']['delivery_charges'],
      );
}
