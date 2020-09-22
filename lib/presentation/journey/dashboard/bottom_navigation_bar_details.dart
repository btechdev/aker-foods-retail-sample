import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum DashboardBottomNavigationItem { home, search, cart, account }

class DashboardBottomNavigationBarData {
  final BuildContext context;

  DashboardBottomNavigationBarData(this.context);

  List<BottomNavigationBarItem> getBottomNavigationBarItemList(
      int cartProductCount) {
    final List<BottomNavigationBarItem> items = List();
    for (final item in DashboardBottomNavigationItem.values) {
      items.add(_getBottomNavigationBarItem(item, cartProductCount));
    }
    return items;
  }

  BottomNavigationBarItem _getBottomNavigationBarItem(
      DashboardBottomNavigationItem item, int cartProductCount) {
    String titleString;
    Widget iconWidget;
    Widget activeIconWidget;
    switch (item) {
      case DashboardBottomNavigationItem.home:
        titleString = 'Home';
        iconWidget = const Icon(Icons.home);
        activeIconWidget = const Icon(
          Icons.home,
          color: AppColor.primaryColor,
        );
        break;

      case DashboardBottomNavigationItem.search:
        titleString = 'Search';
        iconWidget = const Icon(Icons.search);
        activeIconWidget = const Icon(
          Icons.search,
          color: AppColor.primaryColor,
        );
        break;

      case DashboardBottomNavigationItem.cart:
        titleString = 'Cart';
        const icon = Icon(Icons.shopping_cart);
        const activeIcon = Icon(
          Icons.shopping_cart,
          color: AppColor.primaryColor,
        );
        iconWidget = cartProductCount > 0
            ? _wrapWithCartProductCount(icon, cartProductCount)
            : icon;
        activeIconWidget = cartProductCount > 0
            ? _wrapWithCartProductCount(activeIcon, cartProductCount)
            : activeIcon;
        break;

      case DashboardBottomNavigationItem.account:
        titleString = 'Account';
        iconWidget = const Icon(Icons.account_box);
        activeIconWidget = const Icon(
          Icons.account_box,
          color: AppColor.primaryColor,
        );
        break;
    }

    return BottomNavigationBarItem(
      title: Text(
        titleString,
        style: Theme.of(context).textTheme.overline,
      ),
      icon: iconWidget,
      activeIcon: activeIconWidget,
    );
  }

  Widget _wrapWithCartProductCount(Icon icon, int cartProductCount) {
    return Stack(
      alignment: Alignment.center,
      children: [
        icon,
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(LayoutConstants.dimen_2.w),
            decoration: BoxDecoration(
              color: AppColor.orangeDark,
              borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
            ),
            constraints: BoxConstraints(
              minWidth: LayoutConstants.dimen_16.w,
              minHeight: LayoutConstants.dimen_16.h,
            ),
            child: Text(
              '$cartProductCount',
              style: Theme.of(context).textTheme.overline.copyWith(
                    color: AppColor.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
