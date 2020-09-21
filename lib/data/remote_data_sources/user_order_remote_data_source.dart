import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserOrderRemoteDataSource {
  final ApiClient apiClient;

  UserOrderRemoteDataSource({this.apiClient});

  Future<List<OrderModel>> getOrders() async {
    final jsonMap = await apiClient.get(ApiEndpoints.orderHistory);
    return ApiResponse.fromJson<OrderModel>(jsonMap).data;
  }
}
