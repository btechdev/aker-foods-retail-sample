import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:flutter/material.dart';

import 'address/choose_your_location/choose_your_location_screen.dart';
import 'address/select_society/select_society_screen.dart';
import 'edit_profile/edit_profile_screen.dart';
import 'my_account/my_account_screen.dart';

class UserJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.myAccount: (context) => MyAccountScreen(),
        RouteConstants.editProfile: (context) => EditProfileScreen(),
        RouteConstants.chooseLocation: (context) => ChooseYourLocationScreen(),
        RouteConstants.selectSociety: (context) => SelectSocietyScreen(),
      };
}
