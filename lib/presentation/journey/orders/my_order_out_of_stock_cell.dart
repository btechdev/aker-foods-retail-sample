import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class MyOrderOutOfStockCell extends StatefulWidget {
  final Function onDelete;
  final Function onNotify;

  MyOrderOutOfStockCell({this.onDelete, this.onNotify});

  @override
  _MyOrderOutOfStockCellState createState() => _MyOrderOutOfStockCellState();
}

class _MyOrderOutOfStockCellState extends State<MyOrderOutOfStockCell> {
  @override
  Widget build(BuildContext context) => Container(
        color: AppColor.white54,
        height: LayoutConstants.dimen_140.h,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: _getBody(context),
      );

  Row _getBody(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: _getItemDetail(context),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  ),
                ),
                FlatButton(
                  onPressed: widget.onNotify,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: AppColor.primaryColor,
                        width: LayoutConstants.dimen_1.w,
                        style: BorderStyle.solid),
                    borderRadius:
                        BorderRadius.circular(LayoutConstants.dimen_8.w),
                  ),
                  child: Text(
                    'Notify Me',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
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
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/user-profile-vegies.jpeg',
                    height: LayoutConstants.dimen_100.h,
                    width: LayoutConstants.dimen_100.w,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: LayoutConstants.dimen_100.h,
                    width: LayoutConstants.dimen_100.w,
                    color: AppColor.white54,
                  ),
                  Positioned(
                    top: LayoutConstants.dimen_40.h,
                    bottom: LayoutConstants.dimen_40.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_10.w),
                      color: AppColor.white,
                      child: Text(
                        'Out of stock',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ],
              )),
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
