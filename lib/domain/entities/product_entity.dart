import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';

class ProductEntity {
  final int id;
  final String name;
  final String description;
  final int categoryId;
  final ProductCategoryEntity category;
  final int subcategoryId;
  final ProductSubcategoryEntity subcategory;
  final double baseQuantity;
  final String salesUnit;
  final double amount;
  final double discountedAmount;
  final String imageUrl;
  bool isInStock;

  ProductEntity({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.category,
    this.subcategoryId,
    this.subcategory,
    this.baseQuantity,
    this.salesUnit,
    this.amount,
    this.discountedAmount,
    this.imageUrl,
    this.isInStock = true,
  });
}
