import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReferralScreen extends StatefulWidget {
  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: _getBanner(),
        floatingActionButton: _shareFloatingActionButton(),
      );

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Refer A Friend',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  Container _getBanner() => Container(
        width: double.infinity,
        height: PixelDimensionUtil().uiHeightPx.toDouble() * 0.5,
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        color: AppColor.primaryColor,
        child: _getColumns(),
      );

  FloatingActionButton _shareFloatingActionButton() => FloatingActionButton(
        onPressed: () => {},
        backgroundColor: AppColor.primaryColor,
        child: const Icon(
          Icons.share,
          color: AppColor.white,
        ),
      );

  Column _getColumns() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getHeaderText('Total Rewards'),
          _getValueText('${AppConstants.rupeeSymbol} 0.0'),
          SizedBox(height: LayoutConstants.dimen_20.h),
          _getHeaderText('Balance'),
          _getValueText('${AppConstants.rupeeSymbol} 0.0'),
          SizedBox(height: LayoutConstants.dimen_20.h),
          _getReferralCodeDescriptionText(
              'Share referral code with your friends and get'
              ' ${AppConstants.rupeeSymbol} 75 as rewards '
              'when they apply and order from AkerFoods'),
          SizedBox(height: LayoutConstants.dimen_20.h),
          _getHeaderText('Your referral code:'),
          _getValueText('ABCD'),
        ],
      );

  Text _getHeaderText(String text) => Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.white,
            ),
      );

  Text _getValueText(String text) => Text(
        text,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: AppColor.white,
            ),
      );

  Text _getReferralCodeDescriptionText(String text) => Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColor.white,
            ),
      );
}
