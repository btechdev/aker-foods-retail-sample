import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/profile_text_field_widget.dart';
import 'package:flutter/material.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class WalletAddMoneyScreen extends StatelessWidget {
  final _topUpAmountTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.dimen_16.h,
            horizontal: LayoutConstants.dimen_16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ProfileTextFieldWidget(
              controller: _topUpAmountTextController,
              prefixIcon: Icon(Icons.money_off),
              hintText: 'Top Amount',
              onTextChange: (value) => {},
            ),
            _buttonWithContainer(context),
          ],
        ),
      ),
    );
  }

  AppBar _getAppBar(BuildContext context) => AppBar(
        title: Text(
          'Add Money',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  Container _buttonWithContainer(BuildContext context) => Container(
    height: LayoutConstants.dimen_48.h,
    margin: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
        vertical: LayoutConstants.dimen_16.h),
    child: RaisedButton(
      color: AppColor.primaryColor,
      onPressed: () => {
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
      ),
      child: Text(
        'Add money',
        style: Theme.of(context).textTheme.button.copyWith(
          color: AppColor.white,
        ),
      ),
    ),
  );
}
