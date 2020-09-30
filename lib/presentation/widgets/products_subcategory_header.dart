import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductsSubcategoryHeader extends StatelessWidget {
  final String title;

  const ProductsSubcategoryHeader({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.orangeDark.withOpacity(0.20),
      height: LayoutConstants.dimen_32.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: AppColor.black,
            ),
      ),
    );
  }
}
