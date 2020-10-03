

abstract class UserOrderEvent {}

class FetchUserOrders extends UserOrderEvent {
  int pageNo;
  int pageSize;

  FetchUserOrders({this.pageNo, this.pageSize});
}

class ReinitiatePaymentForOrderEvent extends UserOrderEvent {
  final String orderId;
  ReinitiatePaymentForOrderEvent({this.orderId});
}

class VerifyOrderTransactionEvent extends UserOrderEvent{
  final String orderId;
  VerifyOrderTransactionEvent({this.orderId});
}