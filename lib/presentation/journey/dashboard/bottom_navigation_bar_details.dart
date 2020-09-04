import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum DashboardBottomNavigationItems { home, search, cart, account }

class DashboardBottomNavigationBarData {
  final BuildContext context;

  DashboardBottomNavigationBarData(this.context);

  List<BottomNavigationBarItem> getBottomNavigationBarItemList() {
    final List<BottomNavigationBarItem> items = List();
    for (final item in DashboardBottomNavigationItems.values) {
      items.add(_getBottomNavigationBarItem(item));
    }
    return items;
  }

  BottomNavigationBarItem _getBottomNavigationBarItem(item) {
    String titleString;
    IconData iconData;
    switch (item) {
      case DashboardBottomNavigationItems.home:
        titleString = 'Home';
        iconData = Icons.home;
        break;

      case DashboardBottomNavigationItems.search:
        titleString = 'Search';
        iconData = Icons.search;
        break;

      case DashboardBottomNavigationItems.cart:
        titleString = 'Cart';
        iconData = Icons.shopping_cart;
        break;

      case DashboardBottomNavigationItems.account:
        titleString = 'Account';
        iconData = Icons.account_box;
        break;
    }

    return BottomNavigationBarItem(
      title: Text(
        titleString,
        style: Theme.of(context).textTheme.overline,
      ),
      icon: Icon(iconData),
      activeIcon: Icon(
        iconData,
        color: AppColor.primaryColor,
      ),
    );
  }
}
