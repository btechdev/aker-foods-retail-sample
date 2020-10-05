import 'package:aker_foods_retail/data/models/cart_product_model.dart';
import 'package:aker_foods_retail/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    String promoCode,
    int paymentMode,
    String deliveryAddress,
    List<CartProductModel> products,
  }) : super(
          promoCode: promoCode,
          paymentMode: paymentMode,
          deliveryAddress: deliveryAddress,
          products: products,
        );
}
