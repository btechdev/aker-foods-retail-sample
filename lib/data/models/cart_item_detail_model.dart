import 'package:aker_foods_retail/data/models/product_detail_model.dart';
import 'package:aker_foods_retail/domain/entities/cart_item_detail_entity.dart';

class CartItemDetailModel extends CartItemDetailEntity {
  CartItemDetailModel({
    int id,
    int cartId,
    int productId,
    ProductDetailModel productDetail,
    double quantity,
    bool isActive,
    double totalPrice,
    double price,
  }) : super(
          id: id,
          cartId: cartId,
          productId: productId,
          productDetail: productDetail,
          quantity: quantity,
          isActive: isActive,
          totalPrice: totalPrice,
          price: price,
        );

  factory CartItemDetailModel.fromJson(Map<String, dynamic> json) =>
      CartItemDetailModel(
        id: json['id'],
        cartId: json['cart_id'],
        productId: json['product_id'],
        productDetail: ProductDetailModel.fromJson(json['product_details']),
        quantity: json['quantity'],
        isActive: json['is_active'],
        totalPrice: json['total_price'],
        price: json['price'],
      );
}
