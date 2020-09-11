import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class MyOrderCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: LayoutConstants.dimen_200.h,
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
          height: LayoutConstants.dimen_40.h,
          color: AppColor.white,
          padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.dimen_16.w,
              vertical: LayoutConstants.dimen_8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _getRatingBar(),
              _getReorderButton(context),
            ],
          ),
        ),
        Divider(
          height: LayoutConstants.dimen_16.h,
          color: AppColor.transparent,
        ),
      ],
    );
  }

  FlatButton _getReorderButton(BuildContext context) => FlatButton(
        onPressed: () => {},
        child: Container(
          alignment: Alignment.centerRight,
          width: LayoutConstants.dimen_80.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.refresh,
                color: AppColor.primaryColor,
              ),
              Text(
                'Reorder',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: AppColor.primaryColor),
              )
            ],
          ),
        ),
      );

  RatingBar _getRatingBar() => RatingBar(
        initialRating: 0,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        ratingWidget: RatingWidget(
          empty: Icon(
            Icons.star_border,
            size: LayoutConstants.dimen_10.w,
            color: AppColor.yellow,
          ),
          half: Icon(
            Icons.star_half,
            size: LayoutConstants.dimen_10.w,
            color: AppColor.yellow,
          ),
          full: Icon(
            Icons.star,
            size: LayoutConstants.dimen_10.w,
            color: AppColor.yellow,
          ),
        ),
        itemSize: LayoutConstants.dimen_20.w,
        onRatingUpdate: (rating) {},
      );

  Row _getRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _getItemDetailsContainer(context),
          _getNavigateToDetailsContainer(context),
        ],
      );

  Container _getItemDetailsContainer(BuildContext context) => Container(
        width: PixelDimensionUtil().uiWidthPx * 0.75,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getTitleAndValue(context, 'Ordern ID', '34607'),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getItemDetails(context,
                'Something, Something, Something, Something, Something,Something, Something, Something, Something, Something'),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getTitleAndValue(context, 'Ordern date', '06 Aug, 20'),
            SizedBox(
              height: LayoutConstants.dimen_8.h,
            ),
            _getTitleAndValue(context, 'Total Amount', 'Rs 151, COD'),
          ],
        ),
      );

  Container _getNavigateToDetailsContainer(BuildContext context) => Container(
        child: Column(
          children: <Widget>[
            Container(
              height: LayoutConstants.dimen_30.h,
              padding: EdgeInsets.all(LayoutConstants.dimen_4.w),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColor.primaryColor,
                    width: LayoutConstants.dimen_1.w),
                borderRadius: BorderRadius.circular(LayoutConstants.dimen_4.w),
              ),
              child: Text(
                'Delivered',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: AppColor.primaryColor,
                    ),
              ),
            ),
            SizedBox(
              height: LayoutConstants.dimen_30.h,
            ),
            Icon(
              Icons.chevron_right,
              color: AppColor.primaryColor,
            )
          ],
        ),
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
