abstract class UserOrderEvent {}

class FetchUserOrders extends UserOrderEvent {
  int pageNo;
  int pageSize;

  FetchUserOrders({this.pageNo, this.pageSize});
}

class ReinitiatePaymentForOrderEvent extends UserOrderEvent {
  final int cartId;

  ReinitiatePaymentForOrderEvent({this.cartId});
}

class VerifyOrderTransactionEvent extends UserOrderEvent {
  final String orderId;
  VerifyOrderTransactionEvent({this.orderId});
}

class OrderPaymentSuccessEvent extends UserOrderEvent {}

class OrderPaymentFailedEvent extends UserOrderEvent {}
