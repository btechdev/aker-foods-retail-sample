import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';

class BannerDataModel extends BannerDataEntity {
  BannerDataModel({
    int id,
    String name,
    String description,
    String type,
    List<String> ids,
    String imageUrl,
  }) : super(
          id: id,
          name: name,
          description: description,
          type: type,
          ids: ids,
          imageUrl: imageUrl,
        );

  // ignore: prefer_constructors_over_static_methods
  static BannerDataModel fromJson(Map<String, dynamic> jsonMap) =>
      BannerDataModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
        description: jsonMap['description'],
        type: jsonMap['type'],
        ids: jsonMap['ids'].cast<String>(),
        imageUrl: jsonMap['image'],
      );
}
