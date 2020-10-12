import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

class SplashRoute {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.splash: (context) => SplashScreen(),
      };
}
