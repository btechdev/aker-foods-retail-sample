import 'package:aker_foods_retail/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    String id,
    String name,
    String quantity,
    double price,
    double discount,
    double couponDiscount,
    ProductStatus status,
  }) : super(
          id: id,
          name: name,
          quantity: quantity,
          price: price,
          discount: discount,
          couponDiscount: couponDiscount,
          status: status,
        );
}
