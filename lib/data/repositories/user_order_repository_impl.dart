import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_order_remote_data_source.dart';
import 'package:aker_foods_retail/domain/entities/order_payment_reinitiate_response_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_order_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserOrderRepositoryImpl implements UserOrderRepository {
  final UserOrderRemoteDataSource userOrderRemoteDataSource;

  UserOrderRepositoryImpl({this.userOrderRemoteDataSource});

  @override
  Future<ApiResponse<OrderModel>> getOrders(int pageNo, int pageSize) async =>
      userOrderRemoteDataSource.getOrders(pageNo, pageSize);

  @override
  Future<OrderPaymentReinitiateResponseEntity> reinitiatePaymentForOrder(
          String orderId) =>
      userOrderRemoteDataSource.reinitiatePaymentForOrder(orderId);

  @override
  Future<bool> verifyTransactionForOrder(int cartId) async =>
      userOrderRemoteDataSource.verifyTransactionForOrder(cartId);
}
