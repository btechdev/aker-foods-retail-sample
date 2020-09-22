import 'package:aker_foods_retail/data/database/hive_table_constants.dart';
import 'package:aker_foods_retail/data/models/cart_model.dart';
import 'package:hive/hive.dart';

import 'cart_product_table.dart';

part 'cart_table.g.dart';

@HiveType(typeId: HiveTypeIdConstants.cartTableId)
class CartTable extends HiveObject {
  @HiveField(0)
  final String promoCode;

  @HiveField(1)
  final String deliveryAddress;

  @HiveField(2)
  final List<CartProductTable> products;

  CartTable({
    this.promoCode,
    this.deliveryAddress,
    this.products = const [],
  });

  factory CartTable.fromModel(CartModel model) => CartTable(
        promoCode: model.promoCode,
        deliveryAddress: model.deliveryAddress,
        products: model.products
            .map((cartProductModel) =>
                CartProductTable.fromModel(cartProductModel))
            .toList(),
      );

  CartModel toModel() => CartModel(
        promoCode: promoCode,
        deliveryAddress: deliveryAddress,
        products: products
            .map((cartProductTable) => cartProductTable.toModel())
            .toList(),
      );
}
