import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductGridDiscountBadge extends StatelessWidget {
  final ProductEntity product;

  const ProductGridDiscountBadge({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double discountValue = product.price - (product.discountedPrice ?? 0);
    if (discountValue > 0) {
      final double discountApplied = (discountValue / product.price) * 100;
      return _appliedDiscountValueTextContainer(context, discountApplied);
    }
    return Container();
  }

  Widget _appliedDiscountValueTextContainer(
          BuildContext context, double discountApplied) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_8.w,
          vertical: LayoutConstants.dimen_4.h,
        ),
        decoration: BoxDecoration(
          color: AppColor.primaryColorDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(LayoutConstants.dimen_8.w),
            bottomRight: Radius.circular(LayoutConstants.dimen_12.w),
          ),
        ),
        child: Text(
          '$discountApplied %',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.white,
              ),
        ),
      );
}
