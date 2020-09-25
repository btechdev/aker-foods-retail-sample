import 'package:aker_foods_retail/data/models/payment_details_model.dart';
import 'package:aker_foods_retail/domain/entities/create_order_response_entity.dart';

class CreateOrderResponseModel extends CreateOrderResponseEntity {
  CreateOrderResponseModel({
    int id,
    String message,
    PaymentDetailsModel paymentDetails,
  }) : super(
          id: id,
          message: message,
          paymentDetails: paymentDetails,
        );

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> jsonMap) {
    PaymentDetailsModel paymentDetails;
    if (jsonMap.containsKey('payment_detail')) {
      paymentDetails = PaymentDetailsModel.fromJson(jsonMap['payment_detail']);
    }
    return CreateOrderResponseModel(
      id: jsonMap['id'],
      message: jsonMap['message'],
      paymentDetails: paymentDetails,
    );
  }
}
