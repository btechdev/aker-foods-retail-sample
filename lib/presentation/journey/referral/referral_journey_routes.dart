import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/referral/referral_screen.dart';
import 'package:flutter/material.dart';

class ReferralJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.referral: (context) => ReferralScreen(),
      };
}
