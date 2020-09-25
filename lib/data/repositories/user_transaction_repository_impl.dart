import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_transaction_remote_datasource.dart';
import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_transaction_repository.dart';

class UserTransactionRepositoryImpl implements UserTransactionRepository {
  final UserTransactionRemoteDataSource userTransactionRemoteDataSource;

  UserTransactionRepositoryImpl({this.userTransactionRemoteDataSource});

  @override
  Future<List<TransactionModel>> getTransactions() async =>
      userTransactionRemoteDataSource.getTransactions();

  @override
  Future<List<CashOfferEntity>> getCashOffers() async =>
      userTransactionRemoteDataSource.getCashOffers();
}
