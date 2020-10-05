import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/domain/entities/cart_item_detail_entity.dart';
import 'package:aker_foods_retail/domain/entities/order_item_tile_entity.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderDetailsItemList extends StatefulWidget {
  final List<CartItemDetailEntity> items;

  OrderDetailsItemList({
    Key key,
    this.items,
  }) : super(key: key);

  @override
  _OrderDetailsItemListState createState() => _OrderDetailsItemListState();
}

class _OrderDetailsItemListState extends State<OrderDetailsItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (_, index) => OrderItemTile(
          id: index,
          product: widget.items[index].productDetail,
          isForDetail: true,
        ),
        itemCount: widget.items.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(top: LayoutConstants.dimen_16.h),
      ),
    );
  }
}
