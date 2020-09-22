import 'package:aker_foods_retail/data/database/hive_table_constants.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:hive/hive.dart';

part 'product_table.g.dart';

@HiveType(typeId: HiveTypeIdConstants.productsTableId)
class ProductTable extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final int categoryId;

  @HiveField(4)
  final int subcategoryId;

  @HiveField(5)
  final double baseQuantity;

  @HiveField(6)
  final String salesUnit;

  @HiveField(7)
  final double amount;

  @HiveField(8)
  final double discountedAmount;

  @HiveField(9)
  final String imageUrl;

  ProductTable({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.subcategoryId,
    this.baseQuantity,
    this.salesUnit,
    this.amount,
    this.discountedAmount,
    this.imageUrl,
  });

  factory ProductTable.fromModel(ProductModel model) => ProductTable(
        id: model.id,
        name: model.name,
        description: model.description,
        categoryId: model.categoryId,
        subcategoryId: model.subcategoryId,
        baseQuantity: model.baseQuantity,
        salesUnit: model.salesUnit,
        amount: model.amount,
        discountedAmount: model.discountedAmount,
        imageUrl: model.imageUrl,
      );

  ProductModel toModel() => ProductModel(
        id: id,
        name: name,
        description: description,
        categoryId: categoryId,
        subcategoryId: subcategoryId,
        baseQuantity: baseQuantity,
        salesUnit: salesUnit,
        amount: amount,
        discountedAmount: discountedAmount,
        imageUrl: imageUrl,
      );
}
