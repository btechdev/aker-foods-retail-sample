import 'package:aker_foods_retail/data/models/order_model.dart';

abstract class UserOrderState {}

class EmptyState extends UserOrderState {}

class UserOrderFetchingState extends UserOrderState {}

class UserOrderFetchSuccessfulState extends UserOrderState {
  final List<OrderModel> orders;

  UserOrderFetchSuccessfulState({this.orders});
}

class UserOrderFetchFailedState extends UserOrderState {
  final String errorMessage;

  UserOrderFetchFailedState({this.errorMessage});
}