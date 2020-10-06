import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'product_grid_discount_badge.dart';

class ProductTileImage extends StatelessWidget {
  final ProductEntity product;

  const ProductTileImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final discountedAmount = product.discountedAmount ?? 0;
    if (discountedAmount > 0) {
      return _productImageWithOverlay(
        context,
        ProductGridDiscountBadge(product: product),
      );
    }
    return _productImageContainer(context);
  }

  Widget _productImageWithOverlay(BuildContext context, Widget overlay) =>
      Stack(
        children: [
          _productImageContainer(context),
          overlay,
        ],
      );

  Container _productImageContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        color: AppColor.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_12.h,
        ),
        child: _productImageClippedRect(context),
      );

  ClipRRect _productImageClippedRect(BuildContext context) => ClipRRect(
        borderRadius: LayoutConstants.defaultBorderRadius,
        child: (product.isInStock ?? false)
            ? _productImage()
            : Stack(
                children: [
                  _productImage(),
                  _outOfStockOverlayContainer(context),
                ],
              ),
      );

  Image _productImage() => product.imageUrl.isNotNullAndEmpty
      ? Image.network(
          product.imageUrl,
          width: LayoutConstants.productsImageSize,
          height: LayoutConstants.productsImageSize,
          fit: BoxFit.cover,
        )
      : Image.asset(
          'assets/images/logo_transparent_background.png',
          width: LayoutConstants.productsImageSize,
          height: LayoutConstants.productsImageSize,
          fit: BoxFit.cover,
        );

  Container _outOfStockOverlayContainer(BuildContext context) => Container(
        width: LayoutConstants.productsImageSize,
        height: LayoutConstants.productsImageSize,
        color: AppColor.white54,
        alignment: Alignment.center,
        child: Container(
          width: LayoutConstants.productsImageSize,
          height: LayoutConstants.dimen_24.h,
          color: AppColor.white,
          alignment: Alignment.center,
          child: Text(
            'Out of stock',
            style: Theme.of(context).textTheme.overline.copyWith(
                  color: AppColor.black54,
                  letterSpacing: 0,
                ),
          ),
        ),
      );
}
