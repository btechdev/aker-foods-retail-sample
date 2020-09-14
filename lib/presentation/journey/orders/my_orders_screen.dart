import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/orders/my_order_cell.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Container(
        height: PixelDimensionUtil().uiHeightPx.toDouble(),
        child: _getOrdersListView(),
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

  ListView _getOrdersListView() => ListView.builder(
        itemBuilder: (context, index) => MyOrderCell(
          index: index,
          onTap: () =>
              Navigator.pushNamed(context, RouteConstants.orderDetails),
        ),
        itemCount: 4,
      );
}
