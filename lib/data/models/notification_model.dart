import 'package:aker_foods_retail/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    String title,
    String description,
    String createdAt,
  }) : super(
          title: title,
          description: description,
          createdAt: createdAt,
        );

  // ignore: prefer_constructors_over_static_methods
  static NotificationModel fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['title'],
        description: json['title'],
        createdAt: json['create_at'],
      );
}
