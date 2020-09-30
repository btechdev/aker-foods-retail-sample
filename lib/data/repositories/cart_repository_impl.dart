import 'package:aker_foods_retail/data/local_data_sources/cart_local_data_source.dart';
import 'package:aker_foods_retail/data/models/billing_model.dart';
import 'package:aker_foods_retail/data/models/cart_model.dart';
import 'package:aker_foods_retail/data/models/cart_product_model.dart';
import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/models/create_order_body_model.dart';
import 'package:aker_foods_retail/data/models/create_order_response_model.dart';
import 'package:aker_foods_retail/data/models/pre_checkout_body_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/cart_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;
  final CartLocalDataSource cartLocalDataSource;

  CartRepositoryImpl({
    this.cartRemoteDataSource,
    this.cartLocalDataSource,
  });

  @override
  Future<List<CouponModel>> getCoupons() async =>
      cartRemoteDataSource.getCoupons();

  @override
  Future<CartModel> getCartData() async =>
      cartLocalDataSource.getModelTypeData();

  @override
  Future<BillingModel> validateCartPreCheckout(
      PreCheckoutBodyModel model) async {
    return cartRemoteDataSource.validateCartPreCheckout(model);
  }

  @override
  Future<CreateOrderResponseModel> createOrder(
      CreateOrderBodyModel model) async {
    return cartRemoteDataSource.createOrder(model);
  }

  @override
  Future<CartModel> addProduct(ProductModel productModel) async {
    final CartModel cartModel = await cartLocalDataSource.getModelTypeData();
    final cartProductModel = cartModel.products.firstWhere(
      (cartProductModel) => cartProductModel.product.id == productModel.id,
      orElse: () => null,
    );
    if (cartProductModel == null) {
      cartModel.products.add(CartProductModel(count: 1, product: productModel));
    } else {
      cartProductModel.count = cartProductModel.count + 1;
    }
    await cartLocalDataSource.insertOrUpdateData(cartModel);
    return cartModel;
  }

  @override
  Future<CartModel> removeProduct(ProductModel productModel) async {
    final CartModel cartModel = await cartLocalDataSource.getModelTypeData();
    final cartProductModel = cartModel.products.firstWhere(
      (cartProductModel) => cartProductModel.product.id == productModel.id,
      orElse: () => null,
    );
    if (cartProductModel == null) {
      return cartModel;
    } else {
      cartProductModel.count = cartProductModel.count - 1;
      if (cartProductModel.count == 0) {
        cartModel.products.remove(cartProductModel);
      }
    }
    await cartLocalDataSource.insertOrUpdateData(cartModel);
    return cartModel;
  }

  @override
  Future<CartModel> saveCart(CartModel cartModel) async {
    await cartLocalDataSource.insertOrUpdateData(cartModel);
    return cartModel;
  }
}
