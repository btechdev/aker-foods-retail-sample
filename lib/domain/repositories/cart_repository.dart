import 'package:aker_foods_retail/data/models/cart_model.dart';
import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';

abstract class CartRepository {
  Future<CartModel> getCartData();

  Future<CartModel> addProduct(ProductModel productModel);

  Future<CartModel> removeProduct(ProductModel productModel);

  Future<List<CouponModel>> getPromoCodes();
}
