import 'package:aker_foods_retail/presentation/journey/orders/my_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';


class OrderJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
    RouteConstants.myOrders: (context) => MyOrdersScreen(),
  };
}
