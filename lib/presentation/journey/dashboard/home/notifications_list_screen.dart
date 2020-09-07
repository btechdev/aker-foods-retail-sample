import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/widget_util.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

// TODO(Bhushan): Dummy notification class for demo
class _NotificationEntity {
  final String title;
  final String content;
  final bool isRead;

  _NotificationEntity(
    this.title,
    this.content, {
    this.isRead = false,
  });
}

class NotificationsListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationsListScreenState();
}

class NotificationsListScreenState extends State<NotificationsListScreen> {
  List<_NotificationEntity> dummyNotifications = [
    _NotificationEntity(
      'Welcome to Aker Foods',
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''',
    ),
    _NotificationEntity(
      'Notification 1',
      '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.''',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: _notificationsListView(),
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

  ListView _notificationsListView() => ListView.builder(
        shrinkWrap: true,
        itemCount: dummyNotifications.length,
        itemBuilder: _buildNotificationsListItem,
      );

  Widget _buildNotificationsListItem(BuildContext context, int index) {
    final bool isNotificationRead = dummyNotifications[index].isRead ?? false;
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
        child: _cardContentContainer(context, index, isNotificationRead),
      ),
    );
  }

  Container _cardContentContainer(
    BuildContext context,
    int index,
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
                ? _notificationTitleText(context, index)
                : _notificationTitleRow(context, index),
            SizedBox(height: LayoutConstants.dimen_4.h),
            Text(
              '${dummyNotifications[index].content}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: AppColor.black40,
                  ),
            ),
          ],
        ),
      );

  Row _notificationTitleRow(BuildContext context, int index) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _notificationTitleText(context, index),
          Container(
            padding: EdgeInsets.only(left: LayoutConstants.dimen_8.w),
            child: CircleAvatar(
              radius: LayoutConstants.dimen_4.w,
              backgroundColor: AppColor.primaryColor,
            ),
          ),
        ],
      );

  Text _notificationTitleText(BuildContext context, int index) => Text(
        '${dummyNotifications[index].title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText1,
      );
}
