import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_tile.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderItemList extends StatefulWidget {
  final List<String> items;
  final Function onIncreased;
  final Function onDecreased;

  OrderItemList({Key key, this.items, this.onIncreased, this.onDecreased})
      : super(key: key);

  @override
  _OrderItemListState createState() => _OrderItemListState();
}

class _OrderItemListState extends State<OrderItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (_, index) =>
            OrderItemTile(
              id: index,
              onItemIncreased: widget.onIncreased,
              onItemDecreased: widget.onDecreased,
            ),
        itemCount: widget.items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: LayoutConstants.dimen_16.h),
      ),
    );
  }
}
