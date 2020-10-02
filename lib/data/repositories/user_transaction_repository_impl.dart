import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_transaction_remote_datasource.dart';
import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_transaction_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserTransactionRepositoryImpl implements UserTransactionRepository {
  final UserTransactionRemoteDataSource userTransactionRemoteDataSource;

  UserTransactionRepositoryImpl({this.userTransactionRemoteDataSource});

  @override
  Future<ApiResponse<TransactionModel>> getTransactions(
          int pageNo, int pageSize) async =>
      userTransactionRemoteDataSource.getTransactions(pageNo, pageSize);

  @override
  Future<List<CashOfferEntity>> getCashOffers() async =>
      userTransactionRemoteDataSource.getCashOffers();
}
