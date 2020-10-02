import 'package:aker_foods_retail/domain/entities/transaction_entity.dart';
import 'package:aker_foods_retail/domain/usecases/user_transaction_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_transaction_event.dart';
import 'user_transaction_state.dart';

class UserTransactionBloc
    extends Bloc<UserTransactionEvent, UserTransactionState> {
  static const pageSize = 10;

  final UserTransactionUseCase userTransactionUseCase;
  final List<TransactionEntity> _transactions = [];

  bool _isLastPageFetched = false;
  int _currentPage = 1;
  String _next;

  UserTransactionBloc({this.userTransactionUseCase}) : super(EmptyState());

  @override
  Stream<UserTransactionState> mapEventToState(
      UserTransactionEvent event) async* {
    if (event is FetchUserTransactionsEvent) {
      yield* _handleFetchTransactionEvent(event);
    } else if (event is FetchUserCashOffersEvent) {
      yield* _handleCashOffersEvent(event);
    }
  }

  Stream<UserTransactionState> _handleFetchTransactionEvent(
      UserTransactionEvent event) async* {
    if (_next == null) {
      yield TransactionFetchingState();
    }

    try {
      final response =
          await userTransactionUseCase.getTransactions(_currentPage, pageSize);
      _transactions.addAll(response.data);
      _next = response.next;
      _currentPage++;
      _isLastPageFetched = _next == null;
      yield TransactionFetchSuccessfulState(transactions: _transactions);
    } catch (e) {
      yield TransactionPaginationFailedState(transactions: _transactions);
    }
  }

  Stream<UserTransactionState> _handleCashOffersEvent(
      UserTransactionEvent event) async* {
    yield CashOfferFetchingState();
    final offers = await userTransactionUseCase.getCashOffers();
    yield CashOfferFetchSuccessfulState(cashOffers: offers);
  }
}
