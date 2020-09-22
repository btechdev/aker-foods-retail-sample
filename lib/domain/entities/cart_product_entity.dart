import 'package:aker_foods_retail/domain/entities/product_entity.dart';

class CartProductEntity {
  int count;
  ProductEntity product;

  CartProductEntity({this.product, this.count});
}
