import 'package:aker_foods_retail/presentation/journey/checkout/checkout_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/dashboard_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/login/login_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/orders/order_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/referral/referral_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/splash/splash_routes.dart';
import 'package:aker_foods_retail/presentation/journey/user/user_journey_routes.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/transaction_journey_routes.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getAll() => {
        ...LoginJourneyRoutes.all(),
        ...DashboardJourneyRoutes.all(),
        ...UserJourneyRoutes.all(),
        ...CheckoutJourneyRoutes.all(),
        ...WalletJourneyRoutes.all(),
        ...OrderJourneyRoutes.all(),
        ...ReferralJourneyRoutes.all(),
        ...ReferralJourneyRoutes.all(),
        ...SplashRoute.all(),
      };

/*
	static Map<String, WidgetBuilder Function(RouteSettings)> getAll() => {
		...LoginJourneyRoutes.all(),
		...UserJourneyRoutes.all(),
	};
*/
}
