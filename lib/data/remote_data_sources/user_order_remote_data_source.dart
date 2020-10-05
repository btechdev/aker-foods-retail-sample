import 'package:aker_foods_retail/common/constants/json_keys_constants.dart';
import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/data/models/order_payment_reinitiate_response_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';
import 'package:aker_foods_retail/network/http/http_constants.dart';

class UserOrderRemoteDataSource {
  final ApiClient apiClient;

  UserOrderRemoteDataSource({this.apiClient});

  Future<ApiResponse<OrderModel>> getOrders(int pageNo, int pageSize) async {
    final jsonMap = await apiClient
        .get('${ApiEndpoints.orderHistory}?page=$pageNo&page_size=$pageSize');
    return ApiResponse<OrderModel>.fromJsonMap(jsonMap);
  }

  Future<OrderPaymentReinitiateResponseModel> reinitiatePaymentForOrder(
      String orderId) async {
    final response = await apiClient.post(
        '${ApiEndpoints.createOrder}$orderId/intiate-transaction/', null);
    return OrderPaymentReinitiateResponseModel.fromJson(response);
  }

  Future<bool> verifyTransactionForOrder(int cartId) async {
    final response = await apiClient
        .get('${ApiEndpoints.createOrder}$cartId/verify-transaction/');
    return response[JsonKeysConstants.responseStatusCode] ==
        HttpConstants.success;
  }
}
