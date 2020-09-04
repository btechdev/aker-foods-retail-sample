import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class ReferralCodeContainer extends StatelessWidget {
  const ReferralCodeContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getDiscountText(context),
                _getDiscountAppliedText(context),
              ],
            ),
          ),
          _getRemoveButtonContainer(context),
        ],
      );

  Text _getDiscountAppliedText(BuildContext context) => Text(
        'Promo/referral code applied successfully',
        style: Theme.of(context).textTheme.caption.copyWith(
              fontSize: LayoutConstants.dimen_12.sp,
            ),
      );

  Text _getDiscountText(BuildContext context) => Text(
        'DISCOUNT',
        style: Theme.of(context).textTheme.bodyText1,
      );

  FlatButton _getRemoveButtonContainer(BuildContext context) => FlatButton(
        onPressed: () => {},
        padding: EdgeInsets.only(left: LayoutConstants.dimen_16.w),
        child: Text(
          'REMOVE',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColor.cautionColor),
        ),
      );
}
