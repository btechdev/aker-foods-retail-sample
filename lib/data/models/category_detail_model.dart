import 'package:aker_foods_retail/domain/entities/category_detail_entity.dart';

class CategoryDetailModel extends CategoryDetailEntity {
  CategoryDetailModel({
    int id,
    String name,
    String description,
    String image,
  }) : super(
          id: id,
          name: name,
          description: description,
          image: image,
        );

  factory CategoryDetailModel.fromJson(Map<String, dynamic> json) =>
      CategoryDetailModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
      );
}
