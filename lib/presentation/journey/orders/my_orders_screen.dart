import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_event.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_state.dart';
import 'package:aker_foods_retail/presentation/journey/orders/my_order_cell.dart';
import 'package:aker_foods_retail/presentation/journey/orders/order_detail_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  UserOrderBloc _userOrderBloc;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    debugPrint('widget');
    _userOrderBloc = Injector.resolve<UserOrderBloc>()..add(FetchUserOrders());
  }

  @override
  void dispose() {
    _userOrderBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: BlocProvider<UserOrderBloc>(
        create: (context) => _userOrderBloc,
        child: Container(
          height: PixelDimensionUtil().uiHeightPx.toDouble(),
          child: _getBody(),
        ),
      ),
    );
  }

  AppBar _getAppBar() => AppBar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  BlocBuilder _getBody() => BlocBuilder<UserOrderBloc, UserOrderState>(
        builder: (context, state) {
          if (state is UserOrderFetchSuccessfulState) {
            return _getOrdersListView(state);
          } else {
            return Container();
          }
        },
      );


  ListView _getOrdersListView(UserOrderFetchSuccessfulState state) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          debugPrint('get next page');
        }
      }
    });
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) => MyOrderCell(
        index: index,
        entity: state.orders[index],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => OrderDetailsScreen(
              order: state.orders[index],
            ),
          ),
        ),
      ),
      itemCount: state.orders.length,
    );
  }
}
