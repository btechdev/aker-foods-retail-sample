import 'package:aker_foods_retail/domain/entities/society_entity.dart';

class SocietyModel extends SocietyEntity {
  SocietyModel({
    String id,
    String name,
  }) : super(
          id: id,
          name: name,
        );

  static List<SocietyModel> fromListJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> societyMapList = jsonMap['societies'];
    return societyMapList
        .map((societyMap) => SocietyModel.fromJson(societyMap))
        .toList();
  }

  factory SocietyModel.fromJson(Map<String, dynamic> jsonMap) => SocietyModel(
        id: jsonMap['id'],
        name: jsonMap['name'],
      );

  static Map<String, dynamic> toJson(SocietyModel societyModel) => {
    'id': societyModel.id,
    'name': societyModel.name,
  };
}
