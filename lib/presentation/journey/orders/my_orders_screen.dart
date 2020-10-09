import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/domain/entities/order_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bottom_navigation_bar_details.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_event.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_state.dart';
import 'package:aker_foods_retail/presentation/journey/orders/my_order_cell.dart';
import 'package:aker_foods_retail/presentation/journey/orders/order_detail_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  bool _isLoading = false;
  final _scrollController = ScrollController();

  bool _userHasComeFromPayment = false;

  UserOrderBloc userOrderBloc;

  void _scrollControllerListener() {
    final scrollPosition = _scrollController.position;
    if (scrollPosition.maxScrollExtent == scrollPosition.pixels &&
        !_isLoading) {
      _isLoading = !_isLoading;
      userOrderBloc.add(FetchUserOrders());
    }
  }

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'My order screen');

    _scrollController.addListener(_scrollControllerListener);
    userOrderBloc = Injector.resolve<UserOrderBloc>()..add(FetchUserOrders());
  }

  @override
  void dispose() {
    userOrderBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userHasComeFromPayment = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: _getAppBar(),
      body: BlocProvider<UserOrderBloc>(
        create: (context) => userOrderBloc,
        child: Container(
          height: PixelDimensionUtil().uiHeightPx.toDouble(),
          child: BlocBuilder<UserOrderBloc, UserOrderState>(
            builder: _userOrderBlocBuilder,
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() => AppBar(
        centerTitle: false,
        backgroundColor: AppColor.white,
        elevation: LayoutConstants.dimen_1,
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headline6,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_userHasComeFromPayment ?? false) {
              Navigator.popUntil(
                context,
                (route) => route.settings.name == RouteConstants.dashboard,
              );
              BlocProvider.of<DashboardBloc>(context).add(
                NavigateToPageEvent(
                  pageIndex: DashboardBottomNavigationItem.home.index,
                ),
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
      );

  Widget _userOrderBlocBuilder(BuildContext context, UserOrderState state) {
    if (state is UserOrderFetchingState) {
      return const CircularLoaderWidget();
    }

    _isLoading = false;
    if (state is UserOrderFetchSuccessfulState) {
      if (state.orders?.isNotEmpty == true) {
        return _getOrdersListView(state);
      }
    } else if (state is UserOrderPaginationFailedState) {
      if (state.orders?.isNotEmpty == true) {
        return _getOrdersListView(state);
      } else {
        return _noDataIndicatorWidgets(message: 'Failed to get orders data.');
      }
    }
    return _noDataIndicatorWidgets();
  }

  ListView _getOrdersListView(UserOrderState state) => ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) => MyOrderCell(
          index: index,
          entity: state.orders[index],
          onTap: () => _onTapOrder(state.orders[index]),
        ),
        itemCount: state.orders.length,
      );

  Future<void> _onTapOrder(OrderEntity order) async {
    final result = await Navigator.push(
      context,
      _orderDetailsScreenRoute(order),
    );
    if(result != null && result is Map) {
      if (result['refreshOrderList'] == true) {
        userOrderBloc.add(FetchUserOrders());
      }
    }
  }

  MaterialPageRoute _orderDetailsScreenRoute(OrderModel order) =>
      MaterialPageRoute(
        builder: (BuildContext context) => OrderDetailsScreen(
          order: order,
        ),
      );

  Widget _noDataIndicatorWidgets({
    String message = 'No orders placed yet.',
  }) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColor.black40,
                ),
          ),
          Container(
            height: LayoutConstants.dimen_48.h,
            margin: EdgeInsets.symmetric(
              horizontal: LayoutConstants.dimen_16.w,
              vertical: LayoutConstants.dimen_16.h,
            ),
            child: RaisedButton(
              color: AppColor.primaryColor,
              shape: LayoutConstants.borderlessRoundedRectangle,
              onPressed: () {
                BlocProvider.of<DashboardBloc>(context).add(
                  NavigateToPageEvent(
                    pageIndex: DashboardBottomNavigationItem.home.index,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text(
                'Go to Home',
                style: Theme.of(context).textTheme.button.copyWith(
                      color: AppColor.white,
                    ),
              ),
            ),
          ),
        ],
      );
}
