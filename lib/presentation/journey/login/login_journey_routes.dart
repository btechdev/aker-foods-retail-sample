import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/login/enter_otp_screen.dart';
import 'package:aker_foods_retail/presentation/journey/login/enter_phone_number_screen.dart';
import 'package:aker_foods_retail/presentation/journey/login/setup_user_profile_screen.dart';
import 'package:flutter/material.dart';

const String loginRoute = '/login';

class LoginJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.enterPhoneNumber: (context) => EnterPhoneNumberScreen(),
        RouteConstants.verifyOtp: (context) => EnterOtpScreen(),
        RouteConstants.setupUserProfile: (context) => SetupUserProfileScreen(),
      };

/*
  static Map<String, WidgetBuilder Function(RouteSettings)> all() => {
        loginRoute: getWidgetBuilder,
      };

  static WidgetBuilder getWidgetBuilder(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.enterPhoneNumber:
        return (context) => EnterPhoneNumberScreen();
      case RouteConstants.verifyOtp:
        return (context) => EnterOtpScreen();
      default:
        return null;
    }
  }
*/
}
