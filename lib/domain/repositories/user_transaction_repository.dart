import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';

abstract class UserTransactionRepository {
  Future<List<TransactionModel>> getTransactions();
  Future<List<CashOfferEntity>> getCashOffers();

}
