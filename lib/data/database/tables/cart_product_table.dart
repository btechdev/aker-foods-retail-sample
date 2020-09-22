import 'package:aker_foods_retail/data/database/hive_table_constants.dart';
import 'package:aker_foods_retail/data/models/cart_product_model.dart';
import 'package:hive/hive.dart';

import 'product_table.dart';

part 'cart_product_table.g.dart';

@HiveType(typeId: HiveTypeIdConstants.cartProductsTableId)
class CartProductTable extends HiveObject {
  @HiveField(0)
  final int count;

  @HiveField(1)
  final ProductTable product;

  CartProductTable({this.count, this.product});

  factory CartProductTable.fromModel(CartProductModel model) =>
      CartProductTable(
        count: model.count,
        product: ProductTable.fromModel(model.product),
      );

  CartProductModel toModel() => CartProductModel(
        count: count,
        product: product.toModel(),
      );
}
