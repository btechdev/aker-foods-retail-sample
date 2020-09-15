import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/checkout_order_screen.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bottom_navigation_bar_details.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/search/search_page.dart';
import 'package:aker_foods_retail/presentation/journey/user/my_account/my_account_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';
import 'home/home_page_copy.dart';

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
    _bottomNavigationPageWidgets = [
      HomePage(),
      SearchPage(),
      CheckoutOrderScreen(),
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
    return BlocProvider<DashboardBloc>(
      lazy: false,
      create: (context) => Injector.resolve<DashboardBloc>(),
      child: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) =>
            _pageController.jumpToPage(state.pageIndex),
        child: _buildScaffold(),
      ),
    );
  }

  Widget _buildScaffold() => Scaffold(
        backgroundColor: AppColor.white,
        body: _getScaffoldBody(),
        bottomNavigationBar: _getBottomNavBarWrappedWithBlocBuilder(),
      );

  BlocBuilder _getBottomNavBarWrappedWithBlocBuilder() =>
      BlocBuilder<DashboardBloc, DashboardState>(
        builder: _buildBottomNavigationBar,
      );

  Widget _getScaffoldBody() => PageView(
        pageSnapping: false,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: _bottomNavigationPageWidgets,
      );

  Widget _buildBottomNavigationBar(
          BuildContext context, DashboardState state) =>
      BottomNavigationBar(
        elevation: 32,
        currentIndex: state.pageIndex,
        type: BottomNavigationBarType.fixed,
        items: _navigationBarData.getBottomNavigationBarItemList(),
        onTap: (index) => BlocProvider.of<DashboardBloc>(context).add(
          NavigateToPageEvent(pageIndex: index ?? 0),
        ),
      );
}
