import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/domain/repositories/user_transaction_repository.dart';

class UserTransactionUseCase {
  final UserTransactionRepository userTransactionRepository;

  UserTransactionUseCase({this.userTransactionRepository});

  Future<List<TransactionModel>> getTransactions() async =>
      userTransactionRepository.getTransactions();
}