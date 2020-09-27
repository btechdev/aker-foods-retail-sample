import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/models/create_order_body_model.dart';
import 'package:aker_foods_retail/data/models/pre_checkout_body_model.dart';
import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';
import 'package:aker_foods_retail/domain/entities/create_order_response_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/repositories/cart_repository.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';

class CartUseCase {
  final CartRepository cartRepository;
  final UserAddressRepository userAddressRepository;

  CartUseCase({
    this.cartRepository,
    this.userAddressRepository,
  });

  Future<CartEntity> getCartData() async => cartRepository.getCartData();

  Future<AddressEntity> getSelectedAddress() async =>
      userAddressRepository.getSelectedAddress();

  Future<BillingEntity> validateCartPreCheckout(CartEntity cartEntity) async =>
      cartRepository.validateCartPreCheckout(
        PreCheckoutBodyModel.fromCartData(cartEntity),
      );

  Future<CreateOrderResponseEntity> createOrder(
    int paymentMode,
    int selectedAddressId,
    CartEntity cartEntity,
  ) async =>
      cartRepository.createOrder(
        CreateOrderBodyModel.fromData(
          paymentMode,
          selectedAddressId,
          cartEntity,
        ),
      );

  Future<CartEntity> addProduct(ProductEntity productEntity) async =>
      cartRepository.addProduct(productEntity);

  Future<CartEntity> removeProduct(ProductEntity productEntity) async =>
      cartRepository.removeProduct(productEntity);

  Future<List<CouponModel>> getCategories() async =>
      cartRepository.getCoupons();
}
