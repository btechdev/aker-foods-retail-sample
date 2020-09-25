class BillingEntity {
  final bool isCouponApplied;
  final double couponAmountSaved;
  final double totalAmount;
  final double discountedAmount;
  final double totalSaved;
  final int deliveryCharges;

  BillingEntity({
    this.isCouponApplied,
    this.couponAmountSaved,
    this.totalAmount,
    this.discountedAmount,
    this.totalSaved,
    this.deliveryCharges,
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
    }''';
  }
}
