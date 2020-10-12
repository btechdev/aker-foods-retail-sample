import 'package:aker_foods_retail/domain/entities/product_entity.dart';

class BillingEntity {
  final bool isCouponApplied;
  final double couponAmountSaved;
  final double totalAmount;
  final double discountedAmount;
  final double totalSaved;
  final double deliveryCharges;
  final double walletAmountUsed;
  final List<ProductEntity> updatedProducts;

  BillingEntity({
    this.isCouponApplied,
    this.couponAmountSaved,
    this.totalAmount,
    this.discountedAmount,
    this.totalSaved,
    this.deliveryCharges,
    this.updatedProducts,
    this.walletAmountUsed,
  });

  @override
  String toString() {
    super.toString();
    return '''{
    isCouponApplied: $isCouponApplied,
    couponAmountSaved: $couponAmountSaved,
    totalAmount: $totalAmount,
    discountedAmount: $discountedAmount,
    totalSaved: $totalSaved,
    deliveryCharges: $deliveryCharges,
    walletAmountUsed: $walletAmountUsed,
    updatedProductsCount: ${updatedProducts?.length}
    }''';
  }
}
