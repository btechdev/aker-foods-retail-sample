import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/location/enter_new_address/enter_new_address_screen.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class ChooseYourLocationScreen extends StatefulWidget {
  ChooseYourLocationScreen({Key key}) : super(key: key);

  @override
  ChooseYourLocationScreenState createState() =>
      ChooseYourLocationScreenState();
}

class ChooseYourLocationScreenState extends State<ChooseYourLocationScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColor.transparent,
          iconTheme: Theme.of(context).appBarTheme.iconTheme.copyWith(
                color: AppColor.black,
              ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height: PixelDimensionUtil().uiHeightPx * 0.55,
              color: AppColor.primaryColor,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: LayoutConstants.dimen_8.h,
                      color: AppColor.black54,
                      offset: Offset(LayoutConstants.dimen_5.h, 0),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: LayoutConstants.dimen_16.w,
                  vertical: LayoutConstants.dimen_16.h,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Select Delivery Location',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(height: LayoutConstants.dimen_4.h),
                      const Divider(color: AppColor.grey),
                      SizedBox(height: LayoutConstants.dimen_8.h),
                      Text(
                        'Your Location'.toUpperCase(),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: AppColor.grey,
                            ),
                      ),
                      SizedBox(height: LayoutConstants.dimen_8.h),
                      _getAddressContainer(context),
                      SizedBox(height: LayoutConstants.dimen_4.h),
                      const Divider(color: AppColor.grey),
                      SizedBox(height: LayoutConstants.dimen_24.h),
                      _buttonWithContainer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Container _getAddressContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: LayoutConstants.dimen_40.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: AppColor.primaryColor,
              size: LayoutConstants.dimen_30.w,
            ),
            SizedBox(width: LayoutConstants.dimen_8.w),
            Expanded(
              child: Text(
                'Splendid County, Lohegaon, Dhanori',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      );

  Container _buttonWithContainer() => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_48.h,
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: Colors.lightGreen,
          onPressed: _showEnterAddressDetailsBottomSheet,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          ),
          child: Text(
            'Proceed',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );

  void _showEnterAddressDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LayoutConstants.dimen_12.w),
          topRight: Radius.circular(LayoutConstants.dimen_12.w),
        ),
      ),
      builder: _buildBottomSheet,
    );
  }

  Widget _buildBottomSheet(BuildContext context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.90,
        initialChildSize: 0.80,
        builder: (context, controller) => EnterNewAddressScreen(
          scrollController: controller,
        ),
      );
}
