import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';

class ProductCategoryEntity {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final List<ProductSubcategoryEntity> subcategories;

  ProductCategoryEntity({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.subcategories,
  });
}
