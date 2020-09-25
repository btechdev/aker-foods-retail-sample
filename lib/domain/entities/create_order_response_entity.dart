import 'package:aker_foods_retail/domain/entities/payment_details_entity.dart';

class CreateOrderResponseEntity {
  final int id;
  final String message;
  final PaymentDetailsEntity paymentDetails;

  CreateOrderResponseEntity({
    this.id,
    this.message,
    this.paymentDetails,
  });
}
