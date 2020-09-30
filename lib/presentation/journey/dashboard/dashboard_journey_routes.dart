import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'home/banner/banner_details_screen.dart';
import 'home/notification/notifications_list_screen.dart';

const String dashboardRoute = '/dashboard';

class DashboardJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.dashboard: (context) => DashboardScreen(),
        RouteConstants.notificationsList: (context) =>
            NotificationsListScreen(),
        RouteConstants.bannerDetails: (context) => BannerDetailsScreen(),
      };
}
