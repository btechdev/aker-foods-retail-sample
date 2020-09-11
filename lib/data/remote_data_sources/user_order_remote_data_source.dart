


import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';

class UserOrderRemoteDataSource {
  final ApiClient apiClient;

  UserOrderRemoteDataSource({this.apiClient});

  Future<List<OrderModel>> getOrders() async => [];
}