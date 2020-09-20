import 'package:aker_foods_retail/domain/entities/product_entity.dart';

import 'product_category_model.dart';
import 'product_subcategory_model.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    int id,
    String name,
    String description,
    int categoryId,
    ProductCategoryModel category,
    int subcategoryId,
    ProductSubcategoryModel subcategory,
    double baseQuantity,
    double price,
    double discountedPrice,
    String unit,
    String imageUrl,
    bool isInStock,
  }) : super(
          id: id,
          name: name,
          description: description,
          categoryId: categoryId,
          category: category,
          subcategoryId: subcategoryId,
          subcategory: subcategory,
          baseQuantity: baseQuantity,
          price: price,
          discountedPrice: discountedPrice,
          unit: unit,
          imageUrl: imageUrl,
          isInStock: isInStock,
        );
}
