import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/network/api/api_response_parser.dart';

class BillingModel extends BillingEntity {
  BillingModel({
    final bool isCouponApplied,
    final double couponAmountSaved,
    final double totalAmount,
    final double discountedAmount,
    final double totalSaved,
    final double deliveryCharges,
    final double walletAmountUsed,
    final List<ProductModel> updatedProducts,
  }) : super(
          isCouponApplied: isCouponApplied,
          couponAmountSaved: couponAmountSaved,
          totalAmount: totalAmount,
          discountedAmount: discountedAmount,
          totalSaved: totalSaved,
          deliveryCharges: deliveryCharges,
          walletAmountUsed: walletAmountUsed,
          updatedProducts: updatedProducts,
        );

  factory BillingModel.fromJson(Map<String, dynamic> jsonMap) {
    final dynamic deliveryCharges = jsonMap['billing']['delivery_charges'];
    final dynamic walletAmountUsed = jsonMap['billing']['wallet_amount_used'];
    return BillingModel(
      isCouponApplied: jsonMap['coupon']['is_applied'],
      couponAmountSaved: jsonMap['coupon']['amount_saved'],
      totalAmount: jsonMap['billing']['total_amount'],
      discountedAmount: jsonMap['billing']['discounted_amount'],
      totalSaved: jsonMap['billing']['total_saved'],
      deliveryCharges: double.tryParse(deliveryCharges?.toString() ?? '0'),
      walletAmountUsed: double.tryParse(walletAmountUsed?.toString() ?? '0'),
      updatedProducts:
          ApiResponseParser.listFromJson<ProductModel>(jsonMap['products']),
    );
  }
}
