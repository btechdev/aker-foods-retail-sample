import 'package:aker_foods_retail/domain/entities/cart_product_entity.dart';

class CartEntity {
  final String promoCode;
  final String deliveryAddress;
  final List<CartProductEntity> products;

  CartEntity({
    this.promoCode,
    this.deliveryAddress,
    this.products,
  });
}
