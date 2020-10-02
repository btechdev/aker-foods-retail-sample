import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

// ignore: one_member_abstracts
abstract class UserOrderRepository {
  Future<ApiResponse<OrderModel>> getOrders(int pageNo, int pageSize);
}
