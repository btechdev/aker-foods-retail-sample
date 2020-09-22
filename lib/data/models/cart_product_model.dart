import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/domain/entities/cart_product_entity.dart';

class CartProductModel extends CartProductEntity {
  CartProductModel({
    int count,
    ProductModel product,
  }) : super(
          count: count,
          product: product,
        );
}
