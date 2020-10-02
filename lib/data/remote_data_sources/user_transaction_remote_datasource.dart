import 'package:aker_foods_retail/data/models/cash_offer_model.dart';
import 'package:aker_foods_retail/data/models/transaction_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserTransactionRemoteDataSource {
  final ApiClient apiClient;

  UserTransactionRemoteDataSource({this.apiClient});

  Future<ApiResponse<TransactionModel>> getTransactions(
      int pageNo, int pageSize) async {
    final jsonMap = await apiClient
        .get('${ApiEndpoints.transactions}?page=$pageNo&page_size=$pageSize');
    return ApiResponse<TransactionModel>.fromJsonMap(jsonMap);
  }

  Future<List<CashOfferModel>> getCashOffers() async {
    final jsonMap = await apiClient.get(ApiEndpoints.cashOffers);
    return ApiResponse.fromJson<CashOfferModel>(jsonMap).data;
  }
}
