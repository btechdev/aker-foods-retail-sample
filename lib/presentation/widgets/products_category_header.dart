import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductsCategoryHeader extends StatelessWidget {
  final bool hasViewAllOption;
  final ProductCategoryEntity category;

  const ProductsCategoryHeader({
    Key key,
    this.hasViewAllOption = false,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: AppColor.primaryColor35,
        height: LayoutConstants.dimen_48.w,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
        ),
        child: (hasViewAllOption ?? false)
            ? _categoryHeaderRow(context)
            : _categoryNameText(context),
      );

  Row _categoryHeaderRow(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _categoryNameText(context),
          _viewAllButton(context),
        ],
      );

  Text _categoryNameText(BuildContext context) => Text(
        category.name,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.black,
            ),
      );

  FlatButton _viewAllButton(BuildContext context) => FlatButton(
        onPressed: () => Navigator.of(context).pushNamed(
          RouteConstants.categoryProducts,
          arguments: category,
        ),
        child: Text(
          'View All',
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.orangeDark,
                decoration: TextDecoration.underline,
              ),
        ),
      );
}
