import 'package:aker_foods_retail/common/constants/payment_constants.dart';

enum PaymentMode { cashOnDelivery, online }

extension PaymentModeExtension on PaymentMode {
  int toInt() {
    return this == PaymentMode.cashOnDelivery
        ? PaymentModeConstants.cashOnDelivery
        : PaymentModeConstants.online;
  }

  static PaymentMode fromInt(int mode) {
    return (mode == null || mode == PaymentModeConstants.cashOnDelivery)
        ? PaymentMode.cashOnDelivery
        : PaymentMode.online;
  }
}
