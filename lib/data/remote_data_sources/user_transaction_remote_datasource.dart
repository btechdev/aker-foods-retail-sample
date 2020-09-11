import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';

class UserTransactionRemoteDataSource {
  final ApiClient apiClient;

  UserTransactionRemoteDataSource({this.apiClient});

  Future<List<TransactionModel>> getTransactions() async => [];
}
