import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';
import 'package:aker_foods_retail/domain/entities/order_payment_reinitiate_response_entity.dart';

abstract class UserOrderRepository {
  Future<ApiResponse<OrderModel>> getOrders(int pageNo, int pageSize);
  Future<OrderPaymentReinitiateResponseEntity> reinitiatePaymentForOrder(
      String orderId);
  Future<bool> verifyTransactionForOrder(int cartId);
}
