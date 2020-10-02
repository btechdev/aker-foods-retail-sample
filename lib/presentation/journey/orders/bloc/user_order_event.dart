

abstract class UserOrderEvent {}

class FetchUserOrders extends UserOrderEvent {
  int pageNo;
  int pageSize;

  FetchUserOrders({this.pageNo, this.pageSize});
}
