import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_transaction_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserTransactionUseCase {
  final UserTransactionRepository userTransactionRepository;

  UserTransactionUseCase({this.userTransactionRepository});

  Future<ApiResponse<TransactionModel>> getTransactions(
          int pageNo, int pageSize) async =>
      userTransactionRepository.getTransactions(pageNo, pageSize);

  Future<List<CashOfferEntity>> getCashOffers() async =>
      userTransactionRepository.getCashOffers();
}
