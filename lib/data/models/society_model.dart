import 'package:aker_foods_retail/domain/entities/society_entity.dart';

class SocietyModel extends SocietyEntity {
  SocietyModel({
    int id,
    String name,
  }) : super(
          id: id,
          name: name,
        );

  static Map<String, dynamic> toJson(SocietyModel societyModel) => {
        'id': societyModel.id,
        'name': societyModel.name,
      };

  // ignore: prefer_constructors_over_static_methods
  static SocietyModel fromJson(Map<String, dynamic> jsonMap) => SocietyModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
      );
}
