import 'package:aker_foods_retail/data/models/product_subcategory_model.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/network/api/api_response_parser.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  ProductCategoryModel({
    int id,
    String name,
    String description,
    String imageUrl,
    List<ProductSubcategoryModel> subcategories,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          subcategories: subcategories,
        );

  // ignore: prefer_constructors_over_static_methods
  static ProductCategoryModel fromJson(Map<String, dynamic> jsonMap) {
    List<ProductSubcategoryModel> subcategories;
    if (jsonMap.containsKey('subcategory_details')) {
      subcategories = ApiResponseParser.listFromJson<ProductSubcategoryModel>(
        jsonMap['subcategory_details'],
      );
    } else {
      subcategories = List();
    }

    return ProductCategoryModel(
      id: jsonMap['id'],
      name: jsonMap['name'],
      description: jsonMap['description'],
      imageUrl: jsonMap['image'],
      subcategories: subcategories,
    );
  }
}
