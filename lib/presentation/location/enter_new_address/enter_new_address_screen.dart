import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class EnterNewAddressScreen extends StatelessWidget {
  final ScrollController scrollController;

  EnterNewAddressScreen({
    this.scrollController,
  }) : super();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.transparent,
        body: KeyboardAvoider(
          autoScroll: true,
          child: _buildForm(context),
        ),
      );

  Widget _buildForm(BuildContext context) => SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.only(
          left: LayoutConstants.dimen_16.w,
          right: LayoutConstants.dimen_16.w,
          top: LayoutConstants.dimen_16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getHeader(context),
            SizedBox(height: LayoutConstants.dimen_16.h),
            _getSelectedLocationContainer(context),
            const Divider(color: AppColor.grey),
            _getTextFieldContainer(context, 'Flat/Building Details *', 'G502'),
            const Divider(color: AppColor.grey),
            _getTextFieldContainer(
                context, 'Society Name *', 'Splendid County'),
            const Divider(color: AppColor.grey),
            _getTextFieldContainer(
                context, 'Landmark *', 'Near Ganapati Bappa Temple'),
            const Divider(color: AppColor.grey),
            SizedBox(height: LayoutConstants.dimen_20.h),
            Text(
              'This address is of your:',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColor.black54,
                  ),
            ),
            SizedBox(height: LayoutConstants.dimen_4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: LayoutConstants.dimen_8.w),
                _getAddressTagButton(context, 'Home'),
                SizedBox(width: LayoutConstants.dimen_8.w),
                _getAddressTagButton(context, 'Work'),
                SizedBox(width: LayoutConstants.dimen_8.w),
                _getAddressTagButton(context, 'Other'),
              ],
            ),
            SizedBox(height: LayoutConstants.dimen_24.h),
            _buttonWithContainer(context),
          ],
        ),
      );

  Row _getHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Enter Address Details',
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          alignment: Alignment.center,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Container _getTextFieldContainer(
    BuildContext context,
    String hintText,
    String text,
  ) =>
      Container(
        height: LayoutConstants.dimen_52.h,
        padding: EdgeInsets.only(top: LayoutConstants.dimen_8.h),
        child: TextField(
          controller: TextEditingController()..text = text,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: _getInputDecoration(
            context: context,
            hintText: hintText,
          ),
        ),
      );

  InputDecoration _getInputDecoration(
          {BuildContext context, String hintText}) =>
      InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.only(left: LayoutConstants.dimen_16.w),
        hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColor.grey,
            ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      );

  FlatButton _getAddressTagButton(BuildContext context, String buttonText) =>
      FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColor.primaryColorDark),
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_20.w),
        ),
        onPressed: () => {},
        child: Text(
          buttonText,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColorDark,
              ),
        ),
      );

  Container _buttonWithContainer(BuildContext context) => Container(
        width: double.infinity,
        height: LayoutConstants.dimen_48.h,
        child: RaisedButton(
          color: AppColor.primaryColor,
          disabledColor: Colors.lightGreen,
          onPressed: () => {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Text(
            'Save Address',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );

  Container _getSelectedLocationContainer(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_8.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR LOCATION',
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: AppColor.primaryColor,
                  ),
            ),
            _getAddressContainer(context)
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
}
