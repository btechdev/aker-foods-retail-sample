import 'package:aker_foods_retail/data/models/cart_product_model.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  @override
  final String promoCode;

  @override
  final String deliveryAddress;

  @override
  final List<CartProductModel> products;

  CartModel({
    this.promoCode,
    this.deliveryAddress,
    this.products = const [],
  });
}
