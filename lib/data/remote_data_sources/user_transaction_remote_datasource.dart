import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserTransactionRemoteDataSource {
  final ApiClient apiClient;

  UserTransactionRemoteDataSource({this.apiClient});

  Future<List<TransactionModel>> getTransactions() async {
    final jsonMap = await apiClient.get(ApiEndpoints.transactions);
    return ApiResponse.fromJson<TransactionModel>(jsonMap).data;
  }
}
