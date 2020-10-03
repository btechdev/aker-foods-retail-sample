import 'package:aker_foods_retail/domain/entities/order_payment_reinitiate_response_entity.dart';

class OrderPaymentReinitiateResponseModel
    extends OrderPaymentReinitiateResponseEntity {
  OrderPaymentReinitiateResponseModel({
    String orderId,
    int amount,
    String currency,
    String title,
    String description,
    String imageUrl,
  }) : super(
          orderId: orderId,
          amount: amount,
          currency: currency,
          title: title,
          description: description,
          imageUrl: imageUrl,
        );

  factory OrderPaymentReinitiateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      OrderPaymentReinitiateResponseModel(
        orderId: json['order_id'],
        amount: json['amount'],
        currency: json['currency'],
        title: json['title'],
        description: json['description'],
        imageUrl: json['image_url'],
      );
}
