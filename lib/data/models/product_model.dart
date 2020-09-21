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
    double amount,
    double discountedAmount,
    String salesUnit,
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
          salesUnit: salesUnit,
          amount: amount,
          discountedAmount: discountedAmount,
          imageUrl: imageUrl,
          isInStock: isInStock,
        );

  // ignore: prefer_constructors_over_static_methods
  static ProductModel fromJson(Map<String, dynamic> jsonMap) => ProductModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        description: jsonMap['description'],
        categoryId: jsonMap['category_id'],
        category: ProductCategoryModel.fromJson(jsonMap['category_detail']),
        subcategoryId: jsonMap['subcategory_id'],
        subcategory:
            ProductSubcategoryModel.fromJson(jsonMap['subcategory_detail']),
        baseQuantity: jsonMap['base_quantity'],
        salesUnit: jsonMap['sales_unit'],
        amount: double.parse(jsonMap['amount']),
        discountedAmount: double.parse(jsonMap['discounted_amount']),
        imageUrl: jsonMap['image'],
        isInStock: jsonMap['in_stock'] == 1,
      );

// TODO(Bhushan): What does these values indicate?
//"in_stock":1,"display_order":0,"is_active":true

// TODO(Bhushan): Why values are in String and not double?
//"amount":"100.00","discounted_amount":"100.00"
}
