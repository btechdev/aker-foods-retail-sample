import 'package:aker_foods_retail/domain/repositories/notification_repository.dart';
import 'package:aker_foods_retail/domain/entities/notification_entity.dart';

class NotificationUseCase {
  final NotificationRepository notificationRepository;

  NotificationUseCase({this.notificationRepository});

  Future<List<NotificationEntity>> getNotifications() async =>
      notificationRepository.getNotifications();
}
