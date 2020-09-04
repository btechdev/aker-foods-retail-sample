import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_tile.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderItemList extends StatefulWidget {
  final List<String> items;
  OrderItemList({Key key, this.items}) : super(key: key);

  @override
  _OrderItemListState createState() => _OrderItemListState();
}

class _OrderItemListState extends State<OrderItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (_, index) => const OrderItemTile(),
        itemCount: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: LayoutConstants.dimen_16.h),
      ),
    );
  }
}
