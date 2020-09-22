import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository cartRepository;

  CartUseCase({this.cartRepository});

  Future<CartEntity> getCartData() async => cartRepository.getCartData();

  Future<CartEntity> addProduct(ProductEntity productEntity) async =>
      cartRepository.addProduct(productEntity);

  Future<CartEntity> removeProduct(ProductEntity productEntity) async =>
      cartRepository.removeProduct(productEntity);

  Future<List<CouponModel>> getCategories() async =>
      cartRepository.getPromoCodes();
}
