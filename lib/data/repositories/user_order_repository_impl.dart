import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_order_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/user_order_repository.dart';

class UserOrderRepositoryImpl implements UserOrderRepository {
  final UserOrderRemoteDataSource userOrderRemoteDataSource;

  UserOrderRepositoryImpl({this.userOrderRemoteDataSource});

  @override
  Future<List<OrderModel>> getOrders() async =>
      userOrderRemoteDataSource.getOrders();
}
