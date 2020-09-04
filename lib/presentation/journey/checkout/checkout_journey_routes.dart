import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/checkout_order_screen.dart';
import 'package:flutter/material.dart';

class CheckoutJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.checkoutOrder: (context) => CheckoutOrderScreen(),
      };
}
