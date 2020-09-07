import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'order_item_counter.dart';

class ProductGridItemTile extends StatefulWidget {
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
  State<StatefulWidget> createState() => ProductGridItemTileState();
}

class ProductGridItemTileState extends State<ProductGridItemTile> {
  int _itemCountInCart = 0;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: AppColor.black25),
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        ),
        child: _getBody(context),
      );

  Column _getBody(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            alignment: Alignment.center,
            color: AppColor.scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.dimen_12.w,
              vertical: LayoutConstants.dimen_12.h,
            ),
            child: CircleAvatar(
              radius: LayoutConstants.dimen_32.w,
              backgroundImage: const ExactAssetImage(
                'assets/images/user-profile-vegies.jpeg',
              ),
            ),
          ),
          _getItemDetail(context),
        ],
      );

  Container _getItemDetail(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: LayoutConstants.dimen_8.h),
            Container(
              height: LayoutConstants.dimen_52.h,
              child: Text(
                widget.productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Text(
              widget.productQuantity,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: AppColor.black40,
                  ),
            ),
            SizedBox(height: LayoutConstants.dimen_8.h),
            Text(
              widget.productRate,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColor.orangeDark,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: LayoutConstants.dimen_8.h),
            _itemCountInCart > 0
                ? OrderItemCounter(
                    counterStart: _itemCountInCart,
                    onCountChanged: (count) {
                      setState(() {
                        _itemCountInCart = count;
                      });
                    },
                  )
                : _buttonWithContainer(context),
          ],
        ),
      );

  Container _buttonWithContainer(BuildContext context) => Container(
        alignment: Alignment.centerRight,
        height: LayoutConstants.dimen_48.h,
        child: FlatButton(
          color: AppColor.primaryColor,
          onPressed: _addOneItemOfProduct,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
          ),
          child: Text(
            'Add'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );

  void _addOneItemOfProduct() {
    setState(() {
      ++_itemCountInCart;
    });
  }
}
