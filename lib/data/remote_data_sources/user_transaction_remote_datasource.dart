import 'package:aker_foods_retail/data/models/cash_offer_model.dart';
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

  Future<List<CashOfferModel>> getCashOffers() async {
    final jsonMap = await apiClient.get(ApiEndpoints.cashOffers);
    return ApiResponse.fromJson<CashOfferModel>(jsonMap).data;
  }
}
