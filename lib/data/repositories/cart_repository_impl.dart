import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/cart_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl({this.cartRemoteDataSource});

  @override
  Future<List<CouponModel>> getPromoCodes() async =>
      cartRemoteDataSource.getPromoCodes();
}
