import 'package:aker_foods_retail/data/models/order_model.dart';

// ignore: one_member_abstracts
abstract class UserOrderRepository {
  Future<List<OrderModel>> getOrders();
}
