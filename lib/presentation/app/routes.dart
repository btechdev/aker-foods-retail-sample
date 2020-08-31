import 'package:aker_foods_retail/presentation/journey/login/login_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/user/user_journey_routes.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => {
        ...LoginJourneyRoutes.all(),
        ...UserJourneyRoutes.all(),
      };

/*
	static Map<String, WidgetBuilder Function(RouteSettings)> getAll() => {
		...LoginJourneyRoutes.all(),
		...UserJourneyRoutes.all(),
	};
*/
}