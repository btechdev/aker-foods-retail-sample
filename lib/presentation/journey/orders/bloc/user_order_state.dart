import 'package:aker_foods_retail/data/models/order_model.dart';

abstract class UserOrderState {
  List<OrderModel> orders;
}

class EmptyState extends UserOrderState {}

class UserOrderFetchingState extends UserOrderState {}

class UserOrderFetchSuccessfulState extends UserOrderState {
  @override
  final List<OrderModel> orders;

  UserOrderFetchSuccessfulState({this.orders});
}

class UserOrderFetchFailedState extends UserOrderState {
  final String errorMessage;

  UserOrderFetchFailedState({this.errorMessage});
}

class UserOrderPaginationFailedState extends UserOrderState {
  @override
  final List<OrderModel> orders;

  UserOrderPaginationFailedState({this.orders});
}