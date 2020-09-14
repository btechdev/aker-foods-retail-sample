import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_counter.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderItemTile extends StatelessWidget {
  final int id;
  final Function onItemIncreased;
  final Function onItemDecreased;
  final bool isForDetail;

  OrderItemTile(
      {Key key,
      this.id,
      this.onItemIncreased,
      this.onItemDecreased,
      this.isForDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        height: LayoutConstants.dimen_140.h,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: _getBody(context),
      );

  Row _getBody(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 2,
            child: _getItemDetail(context),
          ),
          if(!isForDetail)
            Expanded(
            flex: 1,
            child: Container(
              child: OrderItemCounter(
                id: id,
                onIncrement: onItemIncreased,
                onDecrement: onItemDecreased,
              ),
            ),
          )
        ],
      );

  Container _getItemDetail(BuildContext context) => Container(
        child: _getItemContainer(context),
      );

  Row _getItemContainer(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(width: LayoutConstants.dimen_10.w),
          _getItemPriceQuantityContainer(context)
        ],
      );

  Column _getItemPriceQuantityContainer(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Onion',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '1 kg',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: LayoutConstants.dimen_16.h),
          Text(
            'Rs 22',
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      );
}
