import 'package:aker_foods_retail/domain/usecases/notification_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUseCase notificationUseCase;

  NotificationBloc({
    this.notificationUseCase,
  }) : super(EmptyState());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is FetchNotificationsEvent) {
      yield* _handleFetchNotificationEvent(event);
    }
  }

  Stream<NotificationState> _handleFetchNotificationEvent(
      FetchNotificationsEvent event) async* {
    yield FetchingNotificationState();
    try {
      final notifications = await notificationUseCase.getNotifications();
      yield FetchNotificationSuccessState(notifications: notifications);
    } catch (e) {
      yield FetchNotificationFailureState();
    }
  }
}
