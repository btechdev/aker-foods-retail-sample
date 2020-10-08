import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bottom_navigation_bar_details.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/cart/cart_page.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/search/search_page.dart';
import 'package:aker_foods_retail/presentation/journey/user/my_account/my_account_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'home/home_page.dart';
import 'search/products_search_page.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  List<Widget> _bottomNavigationPageWidgets;

  DashboardBottomNavigationBarData _navigationBarData;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(RegisterUserDeviceEvent());
    /*BlocProvider.of<DashboardBloc>(context)
      ..add(RegisterUserDeviceEvent())
      ..add(FetchCurrentLocationEvent());*/
    _bottomNavigationPageWidgets = [
      HomePage(),
      ProductsSearchPage(),
      CartPage(),
      MyAccountScreen(),
    ];
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _navigationBarData = DashboardBottomNavigationBarData(context);
    return MultiBlocListener(
      listeners: _dashboardBlocListeners(),
      child: _buildScaffold(),
    );
  }

  List<BlocListener> _dashboardBlocListeners() => [
        BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) {
            if (state is PageLoadedState) {
              _pageController.jumpToPage(state.pageIndex);
            }
          },
        ),
        BlocListener<CartBloc, CartState>(
          listener: _cartBlocStateListener,
        ),
      ];

  void _cartBlocStateListener(BuildContext context, CartState state) {
    // TODO(Bhushan): Check if this is needed.
  }

  Widget _buildScaffold() => Scaffold(
        backgroundColor: AppColor.white,
        body: _getScaffoldBody(),
        bottomNavigationBar: _getBottomNavBarWrappedWithBlocBuilder(),
      );

  BlocBuilder _getBottomNavBarWrappedWithBlocBuilder() =>
      BlocBuilder<CartBloc, CartState>(
        builder: (_, cartState) {
          return BlocBuilder<DashboardBloc, DashboardState>(
            buildWhen: (_, currentState) => currentState is PageLoadedState,
            builder: (context, dashboardState) {
              return _buildBottomNavigationBar(
                  context, cartState, dashboardState);
            },
          );
        },
      );

  Widget _getScaffoldBody() => PageView(
        pageSnapping: false,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: _bottomNavigationPageWidgets,
      );

  Widget _buildBottomNavigationBar(
    BuildContext context,
    CartState cartState,
    DashboardState dashboardState,
  ) =>
      BottomNavigationBar(
        elevation: 32,
        iconSize: 36,
        currentIndex: dashboardState.pageIndex,
        type: BottomNavigationBarType.fixed,
        items: _navigationBarData
            .getBottomNavigationBarItemList(cartState.totalProductCount),
        onTap: (index) => BlocProvider.of<DashboardBloc>(context).add(
          NavigateToPageEvent(pageIndex: index ?? 0),
        ),
      );
}
