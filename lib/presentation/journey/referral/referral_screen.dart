import 'dart:io';

import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/domain/entities/referral_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReferralScreen extends StatefulWidget {
  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  ReferralEntity referralEntity;

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'Referral screen');
  }

  @override
  Widget build(BuildContext context) {
    referralEntity = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBanner(),
      floatingActionButton: _shareFloatingActionButton(),
    );
  }

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Refer Friends',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  Container _getBanner() => Container(
        width: double.infinity,
        height: PixelDimensionUtil().uiHeightPx.toDouble() * 0.3,
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        color: AppColor.primaryColor,
        child: _getColumns(),
      );

  FloatingActionButton _shareFloatingActionButton() => FloatingActionButton(
        onPressed: () => _onShare(context),
        backgroundColor: AppColor.primaryColor,
        child: const Icon(
          Icons.share,
          color: AppColor.white,
        ),
      );

  Column _getColumns() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getReferralCodeDescriptionText('${referralEntity?.title ?? ''}'
              ' ${referralEntity?.description ?? ''}'),
          SizedBox(height: LayoutConstants.dimen_20.h),
          _getHeaderText('Your referral code:'),
          _getValueText(referralEntity?.code ?? ''),
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

  Future<void> _onShare(BuildContext context) async {
    // TODO(soham): Handle the network call to download image properly

    AnalyticsUtil.trackEvent(eventName: 'Share button clicked');
    final request =
        await HttpClient().getUrl(Uri.parse(referralEntity.imageUrl));
    final response = await request.close();
    final bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Aker Foods', 'image.jpg', bytes, 'image/jpg',
        text: '${referralEntity.title} \n'
            '${referralEntity.description}\n'
            'Apply code: ${referralEntity.code}');
  }
}
