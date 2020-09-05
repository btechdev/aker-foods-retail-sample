import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/checkout_order_screen.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bottom_navigation_bar_details.dart';
import 'package:aker_foods_retail/presentation/journey/user/my_account/my_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  List<Widget> _bottomNavigationPageWidgets;

  DashboardBottomNavigationBarData _navigationBarData;

  Container _dummyContainer(String string) => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: Text(
          string,
          textAlign: TextAlign.center,
        ),
      );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _bottomNavigationPageWidgets = [
      _dummyContainer('Home'),
      _dummyContainer('Search'),
      CheckoutOrderScreen(),
      MyAccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _navigationBarData = DashboardBottomNavigationBarData(context);
    return BlocProvider<DashboardBloc>(
      lazy: false,
      create: (context) => Injector.resolve<DashboardBloc>()
        ..add(NavigateToPageEvent(pageIndex: 0)),
      child: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) => {},
        child: _buildScaffold(),
      ),
    );
  }

  Widget _buildScaffold() => Scaffold(
        body: _getScaffoldBody(),
        bottomNavigationBar: _getBottomNavBarWrappedWithBlocBuilder(),
      );

  BlocBuilder _getBottomNavBarWrappedWithBlocBuilder() =>
      BlocBuilder<DashboardBloc, DashboardState>(
        builder: _buildBottomNavigationBar,
      );

  Widget _getScaffoldBody() => PageView(
        pageSnapping: true,
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: _bottomNavigationPageWidgets,
      );

  Widget _buildBottomNavigationBar(
    BuildContext context,
    DashboardState state,
  ) {
    if (state is PageLoadedState) {
      _pageController.jumpToPage(state.pageIndex);
      return BottomNavigationBar(
        elevation: 32,
        currentIndex: state.pageIndex,
        type: BottomNavigationBarType.fixed,
        items: _navigationBarData.getBottomNavigationBarItemList(),
        onTap: (index) => BlocProvider.of<DashboardBloc>(context).add(
          NavigateToPageEvent(pageIndex: index),
        ),
      );
    }
    return Container();
  }
}
