

import 'package:aker_foods_retail/domain/entities/transaction_entity.dart';

abstract class UserTransactionState {}

class EmptyState extends UserTransactionState {}

class TransactionFetchingState extends UserTransactionState {}

class TransactionFetchSuccessfulState extends UserTransactionState {
  final List<TransactionEntity> transactions;

  TransactionFetchSuccessfulState({this.transactions});
}

class TransactionFetchFailedState extends UserTransactionState {
  final String errorMessage;

  TransactionFetchFailedState({this.errorMessage});
}