import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/data/repositories/products_repository_impl.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_counter.dart';
import 'package:aker_foods_retail/presentation/widgets/product_info_price_widget.dart';
import 'package:flutter/material.dart';

class OrderItemTile extends StatelessWidget {
  final int id;
  final Function onItemIncreased;
  final Function onItemDecreased;
  final bool isForDetail;

  OrderItemTile({
    Key key,
    this.id,
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

  Image _productImage() => Image.asset(
        'assets/images/user-profile-vegies.jpeg',
        width: LayoutConstants.dimen_100.w,
        height: LayoutConstants.dimen_100.h,
        fit: BoxFit.cover,
      );

  Container _productDetailsContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: LayoutConstants.dimen_12.w),
        child: ProductInfoPrice(
          product: ProductsRepositoryImpl.dummyProducts[0],
        ),
      );
}
