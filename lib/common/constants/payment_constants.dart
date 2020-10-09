abstract class PaymentModeConstants {
  static const cashOnDelivery = 1;
  static const online = 2;
}

abstract class OrderPaymentStatus {
  static const notPaid = 0;
  static const partiallyPaid = 1;
  static const fullyPaid = 2;
  static const cancelled = 3;

}