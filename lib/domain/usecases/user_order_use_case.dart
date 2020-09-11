import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/domain/repositories/user_order_repository.dart';

class UserOrderUseCase {
  final UserOrderRepository userOrderRepository;

  UserOrderUseCase({this.userOrderRepository});

  Future<List<OrderModel>> getOrders() async => userOrderRepository.getOrders();
}
