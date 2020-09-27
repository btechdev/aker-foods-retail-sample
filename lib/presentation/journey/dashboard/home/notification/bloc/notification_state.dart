import 'package:aker_foods_retail/domain/entities/notification_entity.dart';

abstract class NotificationState {}

class EmptyState extends NotificationState {}

class FetchingNotificationState extends NotificationState {}

class FetchNotificationSuccessState extends NotificationState {
  final List<NotificationEntity> notifications;

  FetchNotificationSuccessState({this.notifications});
}

class FetchNotificationFailureState extends NotificationState {}
