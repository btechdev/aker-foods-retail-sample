import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductInfoPrice extends StatelessWidget {
  final ProductEntity product;

  const ProductInfoPrice({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: LayoutConstants.dimen_52.h,
          child: Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Text(
          '${product.baseQuantity} ${product.unit}',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: AppColor.black40,
              ),
        ),
        SizedBox(height: LayoutConstants.dimen_8.h),
        _getProductPriceRow(context),
      ],
    );
  }

  Row _getProductPriceRow(BuildContext context) {
    final double productMrp = product.price ?? 0;
    final double productDiscountPrice = product.discountedPrice ?? 0;
    final double priceDiscountValue = productMrp - productDiscountPrice;

    final List<Widget> rowChildren = List()
      ..add(_productPriceText(context, productDiscountPrice));
    if (priceDiscountValue > 0) {
      rowChildren
        ..add(SizedBox(width: LayoutConstants.dimen_4.w))
        ..add(_productMrpFlexibleText(context, productMrp));
    }
    return Row(children: rowChildren);
  }

  Text _productPriceText(BuildContext context, double productPrice) => Text(
        '${AppConstants.rupeeSymbol} $productPrice',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.orangeDark,
              fontWeight: FontWeight.w600,
            ),
      );

  Flexible _productMrpFlexibleText(BuildContext context, double productMrp) =>
      Flexible(
        child: Text(
          '${AppConstants.rupeeSymbol} $productMrp',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.black40,
                decoration: TextDecoration.lineThrough,
              ),
        ),
      );
}
