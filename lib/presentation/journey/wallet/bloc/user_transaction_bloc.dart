import 'package:aker_foods_retail/domain/usecases/user_transaction_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_transaction_event.dart';
import 'user_transaction_state.dart';

class UserTransactionBloc
    extends Bloc<UserTransactionEvent, UserTransactionState> {
  final UserTransactionUseCase userTransactionUseCase;

  UserTransactionBloc({this.userTransactionUseCase}) : super(EmptyState());

  @override
  Stream<UserTransactionState> mapEventToState(
      UserTransactionEvent event) async* {
    if (event is FetchUserTransactions) {
      _handleFetchTransactionEvent(event);
    }
  }

  Stream<UserTransactionState> _handleFetchTransactionEvent(
      UserTransactionEvent event) async* {
    yield TransactionFetchingState();
    final transactions = await userTransactionUseCase.getTransactions();
    yield TransactionFetchSuccessfulState(transactions: transactions);
  }
}
