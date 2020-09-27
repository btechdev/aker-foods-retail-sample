import 'package:aker_foods_retail/domain/entities/notification_entity.dart';

// ignore: one_member_abstracts
abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications();
}
