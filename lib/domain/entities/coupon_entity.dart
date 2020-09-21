class CouponEntity {
  String code;
  String description;
  double minimumCartValue;
  DiscountEntity discount;

  CouponEntity({
    this.code,
    this.description,
    this.minimumCartValue,
    this.discount,
  });
}

class DiscountEntity {
  double value;
  bool isPercentage;

  DiscountEntity({this.value, this.isPercentage});
}
