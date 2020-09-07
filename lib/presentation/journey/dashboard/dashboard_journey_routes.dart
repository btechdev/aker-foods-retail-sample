import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/dashboard_screen.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/notifications_list_screen.dart';
import 'package:flutter/material.dart';

const String dashboardRoute = '/dashboard';

class DashboardJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.dashboard: (context) => DashboardScreen(),
        RouteConstants.notificationsList: (context) =>
            NotificationsListScreen(),
      };
}
