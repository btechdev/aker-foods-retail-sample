import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  ProductCategoryModel({
    int id,
    String name,
    String description,
    String imageUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
        );

  // ignore: prefer_constructors_over_static_methods
  static ProductCategoryModel fromJson(Map<String, dynamic> jsonMap) =>
      ProductCategoryModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        description: jsonMap['description'],
        imageUrl: jsonMap['image'],
      );
}
