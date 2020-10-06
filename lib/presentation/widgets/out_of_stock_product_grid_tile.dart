import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'notify_me_button.dart';
import 'product_info_price_widget.dart';
import 'product_tile_image_widget.dart';

class OutOfStockProductGridTile extends StatefulWidget {
  final ProductEntity product;
  final VoidCallback onPressedNotify;

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
          ProductTileImage(product: widget.product),
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

  Container _productInfoContainer() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_4.h,
        ),
        child: ProductInfoPrice(product: widget.product),
      );
}
