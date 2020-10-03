import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'notify_me_button.dart';
import 'product_info_price_widget.dart';

class OutOfStockProductGridTile extends StatefulWidget {
  final ProductEntity product;
  final Function onPressedNotify;

  const OutOfStockProductGridTile({
    Key key,
    @required this.product,
    this.onPressedNotify,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => OutOfStockProductGridTileState();
}

class OutOfStockProductGridTileState extends State<OutOfStockProductGridTile> {
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
          _productImageContainer(),
          _productInfoContainer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.dimen_12.w,
              vertical: LayoutConstants.dimen_8.h,
            ),
            alignment: Alignment.centerRight,
            child: NotifyMeButton(onPressed: widget.onPressedNotify),
          ),
        ],
      );

  Container _productImageContainer() => Container(
        alignment: Alignment.center,
        color: AppColor.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_16.h,
        ),
        child: _productImageClippedRect(),
      );

  ClipRRect _productImageClippedRect() => ClipRRect(
        borderRadius: LayoutConstants.defaultBorderRadius,
        child: Stack(
          children: <Widget>[
            _productImage(),
            _outOfStockOverlayContainer(),
          ],
        ),
      );

  Image _productImage() {
    final imageWidth = LayoutConstants.dimen_100.w;
    final imageHeight = LayoutConstants.dimen_100.h;
    return widget.product.imageUrl.isNotNullAndEmpty
        ? Image.network(
            widget.product.imageUrl,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          )
        : Image.asset(
            'assets/images/logo_transparent_background.png',
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          );
  }

  Container _outOfStockOverlayContainer() => Container(
        width: LayoutConstants.dimen_100.w,
        height: LayoutConstants.dimen_100.h,
        color: AppColor.white54,
        alignment: Alignment.center,
        child: Container(
          width: LayoutConstants.dimen_100.w,
          height: LayoutConstants.dimen_24.h,
          color: AppColor.white,
          alignment: Alignment.center,
          child: Text(
            'Out of stock',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColor.black54,
                ),
          ),
        ),
      );

  Container _productInfoContainer() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: ProductInfoPrice(product: widget.product),
      );
}
