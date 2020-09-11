import 'package:aker_foods_retail/data/models/transaction_model.dart';

// ignore: one_member_abstracts
abstract class UserTransactionRepository {
  Future<List<TransactionModel>> getTransactions();
}
