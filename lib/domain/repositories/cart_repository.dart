import 'package:aker_foods_retail/data/models/billing_model.dart';
import 'package:aker_foods_retail/data/models/cart_model.dart';
import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/models/create_order_body_model.dart';
import 'package:aker_foods_retail/data/models/create_order_response_model.dart';
import 'package:aker_foods_retail/data/models/pre_checkout_body_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';

abstract class CartRepository {
  Future<CartModel> getCartData();

  Future<BillingModel> validateCartPreCheckout(PreCheckoutBodyModel model);

  Future<CreateOrderResponseModel> createOrder(CreateOrderBodyModel model);

  Future<CartModel> addProduct(ProductModel productModel);

  Future<CartModel> removeProduct(ProductModel productModel);

  Future<CartModel> saveCart(CartModel cartModel);

  Future<List<CouponModel>> getCoupons();
}
