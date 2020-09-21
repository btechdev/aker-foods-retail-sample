import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';

class ProductSubcategoryModel extends ProductSubcategoryEntity {
  ProductSubcategoryModel({
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
  static ProductSubcategoryModel fromJson(Map<String, dynamic> jsonMap) =>
      ProductSubcategoryModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        description: jsonMap['description'],
        imageUrl: jsonMap['image'],
      );
}
