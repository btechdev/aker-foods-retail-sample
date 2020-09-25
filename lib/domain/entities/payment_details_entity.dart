class PaymentDetailsEntity {
  final String orderId;
  final int amount;
  final String currency;
  final String title;
  final String description;
  final String imageUrl;

  PaymentDetailsEntity({
    this.orderId,
    this.amount,
    this.currency,
    this.title,
    this.description,
    this.imageUrl,
  });
}
