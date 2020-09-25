import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CouponPromoCodeWidget extends StatelessWidget {
  final String code;
  final Function onRemoveAppliedCode;

  CouponPromoCodeWidget({
    this.code,
    this.onRemoveAppliedCode,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_60.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
        ),
        child: code.isEmpty
            ? _primaryColorText(context, 'Apply coupon/promo code')
            : _appliedCodeRow(context),
      );

  Text _primaryColorText(BuildContext context, String text) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.primaryColor,
            ),
      );

  Row _appliedCodeRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _primaryColorText(context, code),
              _codeAppliedSubtitleText(context),
            ],
          ),
          _removeButton(context),
        ],
      );

  Text _codeAppliedSubtitleText(BuildContext context) => Text(
        'Code applied successfully',
        style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: LayoutConstants.dimen_12.sp,
            ),
      );

  FlatButton _removeButton(BuildContext context) => FlatButton(
        onPressed: onRemoveAppliedCode,
        child: Text(
          'Remove'.toUpperCase(),
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.cautionColor,
              ),
        ),
      );
}
