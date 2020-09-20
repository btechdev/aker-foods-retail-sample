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
  final double price;
  final double discountedPrice;
  final String unit;
  final String imageUrl;
  final bool isInStock;

  ProductEntity({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.category,
    this.subcategoryId,
    this.subcategory,
    this.baseQuantity,
    this.price,
    this.discountedPrice,
    this.unit,
    this.imageUrl,
    this.isInStock = true,
  });
}

/*enum ProductStatus { available, outOfStock, unknown }

extension ProductStatusExtension on ProductStatus {
  String getString() {
    switch (this) {
      case ProductStatus.available:
        return 'AVAILABLE';

      case ProductStatus.outOfStock:
        return 'OUT_OF_STOCK';

      default:
        return 'UNKNOWN';
    }
  }

  static ProductStatus getEnum(String status) {
    switch (status) {
      case 'AVAILABLE':
        return ProductStatus.available;

      case 'OUT_OF_STOCK':
        return ProductStatus.outOfStock;

      default:
        return ProductStatus.unknown;
    }
  }
}*/
