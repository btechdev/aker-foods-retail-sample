import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/order_item_tile_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_counter.dart';
import 'package:aker_foods_retail/presentation/widgets/product_info_price_widget.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final int id;
  final OrderItemTileEntity item;
  final Function onItemIncreased;
  final Function onItemDecreased;
  final bool isForDetail;

  OrderItemTile({
    Key key,
    this.id,
    this.item,
    this.onItemIncreased,
    this.onItemDecreased,
    this.isForDetail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        shape: LayoutConstants.borderlessRoundedRectangle,
        child: Container(
          height: LayoutConstants.dimen_140.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_12.w,
            vertical: LayoutConstants.dimen_12.h,
          ),
          child: _productDetailsRow(context),
        ),
      );

  Row _productDetailsRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _productImageClippedRect(),
          Expanded(
            flex: 3,
            child: _productDetailsContainer(context),
          ),
          if (!isForDetail)
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: OrderItemCounter(
                  id: id,
                  onIncrement: onItemIncreased,
                  onDecrement: onItemDecreased,
                ),
              ),
            )
        ],
      );

  ClipRRect _productImageClippedRect() => ClipRRect(
        borderRadius: LayoutConstants.defaultBorderRadius,
        child: _productImage(),
      );

  Image _productImage() => Image.network(
        item.imageUrl ?? 'https://picsum.photos/id/1080/100/100',
        width: LayoutConstants.dimen_100.w,
        height: LayoutConstants.dimen_100.h,
        fit: BoxFit.cover,
      );

  Container _productDetailsContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: LayoutConstants.dimen_12.w),
        child: ProductInfoPrice(
          product: ProductEntity(
            name: item.itemName,
            amount: item.price,
          ),
        ),
      );
}
