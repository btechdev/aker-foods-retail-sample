import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:flutter/material.dart';

import 'wallet_add_money_screen.dart';
import 'wallet_cashback_offer_screen.dart';
import 'wallet_transactions_screen.dart';

class WalletJourneyRoutes {
  static Map<String, WidgetBuilder> all() => {
        RouteConstants.myWalletTransactions: (context) =>
            WalletTransactionsScreen(),
        RouteConstants.myWalletCashbackOffers: (context) =>
            WalletCashbackOffersScreen(),
        RouteConstants.myWalletAddMoney: (context) => WalletAddMoneyScreen(),
      };
}
