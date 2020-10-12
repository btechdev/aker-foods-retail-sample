import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/constants/payment_constants.dart';
import 'package:aker_foods_retail/common/utils/date_utils.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/domain/entities/cart_item_detail_entity.dart';
import 'package:aker_foods_retail/domain/entities/order_entity.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/payment_mode.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class MyOrderCell extends StatelessWidget {
  final OrderEntity entity;
  final Function onTap;
  final int index;

  MyOrderCell({this.entity, this.onTap, this.index});

  String _getItemQuantityText(List<CartItemDetailEntity> cartItemDetailEntity) {
    final text = StringBuffer();
    for (final item in cartItemDetailEntity) {
      text.writeln('${item.quantity} x ${item.productDetail.baseQuantity}'
          ' ${item.productDetail.salesUnit} '
          '${item.productDetail.name},');
    }
    return text.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            height: LayoutConstants.dimen_190.h,
            color: AppColor.white,
            padding: EdgeInsets.symmetric(
                horizontal: LayoutConstants.dimen_16.w,
                vertical: LayoutConstants.dimen_8.h),
            child: _getRow(context),
          ),
          Divider(
            height: LayoutConstants.dimen_1.h,
          ),
          Container(
            height: LayoutConstants.dimen_8.h,
            color: AppColor.white,
          ),
        ],
      ),
    );
  }

  Row _getRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _getItemDetailsContainer(context),
          _getNavigateToDetailsContainer(context),
        ],
      );

  Container _getItemDetailsContainer(BuildContext context) => Container(
        width: PixelDimensionUtil.screenWidthDp * 0.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitleAndValue(context, 'Order ID', entity.orderId),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getItemDetails(
              context,
              _getItemQuantityText(entity.cartItemDetail),
            ),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getTitleAndValue(context, 'Order date',
                DateUtils.getFormatterDate(entity.createdAt)),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getTitleAndValue(context, 'Total Amount',
                '${AppConstants.rupeeSymbol} ${entity.totalAmount}'),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getPaymentStatus(context),
          ],
        ),
      );

  Expanded _getNavigateToDetailsContainer(BuildContext context) => Expanded(
        flex: 2,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: LayoutConstants.dimen_30.h,
                padding: EdgeInsets.all(LayoutConstants.dimen_4.w),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColor.primaryColor,
                      width: LayoutConstants.dimen_1.w),
                  borderRadius:
                      BorderRadius.circular(LayoutConstants.dimen_4.w),
                ),
                child: Text(
                  entity.status,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: AppColor.primaryColor,
                      ),
                ),
              ),
              SizedBox(
                height: LayoutConstants.dimen_30.h,
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColor.primaryColor,
              )
            ],
          ),
        ),
      );

  Row _getPaymentStatus(BuildContext context) {
    const title = 'Payment Status: ';
    var value = '';
    if (entity.paymentType == PaymentModeConstants.cashOnDelivery) {
      value = 'Cash on Delivery';
      return _getTitleAndValue(context, title, value);
    } else {
      value = entity.getPaymentStatus();
    }
    if (entity.paymentStatus != OrderPaymentStatus.fullyPaid) {
      return _getFailedTitleAndValue(context, title, 'Failed');
    }
    return _getTitleAndValue(context, title, value);
  }

  Row _getFailedTitleAndValue(
          BuildContext context, String title, String value) =>
      Row(
        children: <Widget>[
          Text(
            '$title: ',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColor.grey,
                ),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: AppColor.cautionColor),
          )
        ],
      );

  Row _getTitleAndValue(BuildContext context, String title, String value) =>
      Row(
        children: <Widget>[
          Text(
            '$title: ',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColor.grey,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      );

  Column _getItemDetails(BuildContext context, String itemQuantity) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Items: ',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColor.grey,
                ),
          ),
          SizedBox(
            height: LayoutConstants.dimen_8.h,
          ),
          Text(
            itemQuantity,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      );
}
