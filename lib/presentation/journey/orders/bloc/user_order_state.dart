import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/domain/entities/order_payment_reinitiate_response_entity.dart';

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

class ReinitiatingPaymentForOrderState extends UserOrderState {}

class ReinitiatePaymentForOrderSuccessfulState extends UserOrderState {
  final OrderPaymentReinitiateResponseEntity order;

  ReinitiatePaymentForOrderSuccessfulState({this.order});
}

class ReinitiatePaymentForOrderFailedState extends UserOrderState {}

class VerifyingOrderTransactionState extends UserOrderState {}

class VerifyOrderTransactionStateSuccessfulState extends UserOrderState {

  VerifyOrderTransactionStateSuccessfulState();
}

class VerifyOrderTransactionStateFailedState extends UserOrderState {}