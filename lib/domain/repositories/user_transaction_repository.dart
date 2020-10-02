import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

abstract class UserTransactionRepository {
  Future<ApiResponse<TransactionModel>> getTransactions(
      int pageNo, int pageSize);

  Future<List<CashOfferEntity>> getCashOffers();
}
