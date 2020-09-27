import 'package:aker_foods_retail/data/remote_data_sources/notification_remote_data_source.dart';
import 'package:aker_foods_retail/domain/entities/notification_entity.dart';
import 'package:aker_foods_retail/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteDataSource notificationRemoteDataSource;

  NotificationRepositoryImpl({this.notificationRemoteDataSource});

  @override
  Future<List<NotificationEntity>> getNotifications() async =>
      notificationRemoteDataSource.getNotifications();
}
