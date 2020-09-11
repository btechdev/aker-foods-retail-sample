

import 'package:aker_foods_retail/data/models/transaction_model.dart';

abstract class UserTransactionState {}

class EmptyState extends UserTransactionState {}

class TransactionFetchingState extends UserTransactionState {}

class TransactionFetchSuccessfulState extends UserTransactionState {
  final List<TransactionModel> transactions;

  TransactionFetchSuccessfulState({this.transactions});
}

class TransactionFetchFailedState extends UserTransactionState {
  final String errorMessage;

  TransactionFetchFailedState({this.errorMessage});
}