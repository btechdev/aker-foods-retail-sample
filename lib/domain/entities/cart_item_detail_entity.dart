import 'package:aker_foods_retail/domain/entities/product_detail_entity.dart';

class CartItemDetailEntity {
  CartItemDetailEntity({
    this.id,
    this.cartId,
    this.productId,
    this.productDetail,
    this.quantity,
    this.isActive,
    this.totalPrice,
    this.price,
  });

  int id;
  int cartId;
  int productId;
  ProductDetailEntity productDetail;
  double quantity;
  bool isActive;
  double totalPrice;
  double price;
}
