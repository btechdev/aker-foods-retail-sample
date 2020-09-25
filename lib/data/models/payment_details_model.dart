import 'package:aker_foods_retail/domain/entities/payment_details_entity.dart';

class PaymentDetailsModel extends PaymentDetailsEntity {
  PaymentDetailsModel({
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

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> jsonMap) =>
      PaymentDetailsModel(
        orderId: jsonMap['order_id'],
        amount: jsonMap['amount'],
        currency: jsonMap['currency'],
        title: jsonMap['title'],
        description: jsonMap['description'],
        imageUrl: jsonMap['image_url'],
      );
}
