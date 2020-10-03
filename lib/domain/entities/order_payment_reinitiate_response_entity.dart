class OrderPaymentReinitiateResponseEntity {
  String orderId;
  int amount;
  String currency;
  String title;
  String description;
  String imageUrl;

  OrderPaymentReinitiateResponseEntity({
    this.orderId,
    this.amount,
    this.currency,
    this.title,
    this.description,
    this.imageUrl,
  });
}
