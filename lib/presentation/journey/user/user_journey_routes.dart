import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:flutter/material.dart';

import 'address/choose_your_location/choose_your_location_screen.dart';
import 'address/select_society/select_society_screen.dart';

class UserJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.chooseLocation: (context) => ChooseYourLocationScreen(),
        RouteConstants.selectSociety: (context) => SelectSocietyScreen(),
      };
}
