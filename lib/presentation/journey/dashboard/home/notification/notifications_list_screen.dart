import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/widget_util.dart';
import 'package:aker_foods_retail/domain/entities/notification_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notification_bloc.dart';
import 'bloc/notification_event.dart';
import 'bloc/notification_state.dart';

class NotificationsListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationsListScreenState();
}

class NotificationsListScreenState extends State<NotificationsListScreen> {
  NotificationBloc notificationBloc;

  @override
  void initState() {
    super.initState();
    notificationBloc = Injector.resolve<NotificationBloc>()
      ..add(FetchNotificationsEvent());
  }

  @override
  void dispose() {
    notificationBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: BlocProvider<NotificationBloc>(
          create: (context) => notificationBloc,
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is FetchNotificationSuccessState) {
                return _notificationsListView(state.notifications);
              } else {
                return Container();
              }
            },
          ),
        ),
      );

  AppBar _getAppBar() => AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppColor.white,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.button,
        ),
      );

  ListView _notificationsListView(List<NotificationEntity> notifications) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: notifications.length,
        itemBuilder: (context, index) => _buildNotificationsListItem(context,
            notificationEntity: notifications[index]),
      );

  Widget _buildNotificationsListItem(BuildContext context,
      {NotificationEntity notificationEntity}) {
    final isNotificationRead = false;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
        vertical: LayoutConstants.dimen_8.h,
      ),
      child: wrapWithMaterialInkWellCard(
        context: context,
        onTap: () => {},
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        shapeBorder: RoundedRectangleBorder(
          side: BorderSide(
            color: isNotificationRead
                ? AppColor.transparent
                : AppColor.primaryColor,
          ),
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        ),
        child: _cardContentContainer(context, notificationEntity, false),
      ),
    );
  }

  Container _cardContentContainer(
    BuildContext context,
    NotificationEntity notification,
    bool isNotificationRead,
  ) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_8.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            isNotificationRead
                ? _notificationTitleText(context, notification.title)
                : _notificationTitleRow(context, notification.title),
            SizedBox(height: LayoutConstants.dimen_4.h),
            Text(
              '${notification.description}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: AppColor.black40,
                  ),
            ),
          ],
        ),
      );

  Row _notificationTitleRow(BuildContext context, String title) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _notificationTitleText(context, title),
          Container(
            padding: EdgeInsets.only(left: LayoutConstants.dimen_8.w),
            child: CircleAvatar(
              radius: LayoutConstants.dimen_4.w,
              backgroundColor: AppColor.primaryColor,
            ),
          ),
        ],
      );

  Text _notificationTitleText(BuildContext context, String title) => Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1,
      );
}