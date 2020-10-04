import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/domain/entities/order_payment_reinitiate_response_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_order_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserOrderUseCase {
  final UserOrderRepository userOrderRepository;

  UserOrderUseCase({this.userOrderRepository});

  Future<ApiResponse<OrderModel>> getOrders(
          int pageNo, int pageSize) async =>
      userOrderRepository.getOrders(pageNo, pageSize);

  Future<OrderPaymentReinitiateResponseEntity> reinitiatePaymentForOrder(
          String orderId) async =>
      userOrderRepository.reinitiatePaymentForOrder(orderId);

  Future<bool> verifyTransactionForOrder(int cartId) async =>
      userOrderRepository.verifyTransactionForOrder(cartId);
}
