

import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';
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

class CashOfferFetchingState extends UserTransactionState {}

class CashOfferFetchSuccessfulState extends UserTransactionState {
  final List<CashOfferEntity> cashOffers;

  CashOfferFetchSuccessfulState({this.cashOffers});
}

class CashOfferFetchFailedState extends UserTransactionState {
  final String errorMessage;

  CashOfferFetchFailedState({this.errorMessage});
}