import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:flutter/material.dart';

import 'order_item_counter.dart';

class ProductGridItemTile extends StatelessWidget {
  final String productName;
  final String productQuantity;
  final String productRate;

  const ProductGridItemTile(
    this.productName,
    this.productQuantity,
    this.productRate, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: _getBody(context),
      );

  Column _getBody(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getItemDetail(context),
          Container(child: const OrderItemCounter()),
        ],
      );

  Container _getItemDetail(BuildContext context) => Container(
        child: _getItemContainer(context),
      );

  Column _getItemContainer(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
            child: Image.asset(
              'assets/images/user-profile-vegies.jpeg',
              height: LayoutConstants.dimen_100.h,
              width: LayoutConstants.dimen_100.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: LayoutConstants.dimen_4.h),
          _getItemPriceQuantityContainer(context)
        ],
      );

  Column _getItemPriceQuantityContainer(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            productQuantity,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: LayoutConstants.dimen_8.h),
          Text(
            productRate,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      );
}
