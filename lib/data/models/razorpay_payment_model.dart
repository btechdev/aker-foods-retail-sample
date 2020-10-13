import 'package:aker_foods_retail/config/configuration.dart';
import 'package:aker_foods_retail/domain/entities/payment_details_entity.dart';
import 'package:flutter/foundation.dart';

class RazorpayPaymentModel {
  int amount;
  String orderId;
  String name;
  String description;
  Map<String, String> preFill;

  RazorpayPaymentModel({
    @required this.amount,
    @required this.orderId,
    this.name,
    this.description,
    this.preFill,
  });

  factory RazorpayPaymentModel.fromPaymentDetails(
          PaymentDetailsEntity paymentDetails) =>
      RazorpayPaymentModel(
        amount: paymentDetails.amount,
        orderId: paymentDetails.orderId,
        name: paymentDetails.title,
        description: paymentDetails.description,
      );

  Map<String, dynamic> toJson() => {
        'key': Configuration.razorpayKey,
        'amount': amount,
        'order_id': orderId,
        'name': name,
        'description': description,
        'prefill': preFill,
        'external': {
          'wallets': ['paytm']
        }
      };
}
