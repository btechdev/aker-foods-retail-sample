import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class AddNewSocietyDialog extends StatefulWidget {
  final Function onAdd;

  AddNewSocietyDialog({Key key, @required this.onAdd}) : super(key: key);

  @override
  _AddNewSocietyDialogState createState() => _AddNewSocietyDialogState();
}

class _AddNewSocietyDialogState extends State<AddNewSocietyDialog> {
  final _societyNameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'Add new society screen');
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColor.black25,
        body: KeyboardAvoider(
          autoScroll: true,
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: _getContainer(context),
            ),
          ),
        ),
      );

  Container _getContainer(BuildContext context) => Container(
        margin: EdgeInsets.all(LayoutConstants.dimen_20.w),
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
        ),
        child: _getColumn(context),
      );

  Column _getColumn(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter society name',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: LayoutConstants.dimen_20.h),
          _getTextBox(context),
          SizedBox(height: LayoutConstants.dimen_20.h),
          _getButtons(context)
        ],
      );

  Row _getButtons(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _cancelButton(),
          SizedBox(width: LayoutConstants.dimen_8.w),
          _addButton(),
        ],
      );

  Container _getTextBox(BuildContext context) => Container(
        color: AppColor.scaffoldBackgroundColor,
        padding: EdgeInsets.all(LayoutConstants.dimen_8.w),
        child: TextField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          controller: _societyNameTextController,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            hintText: 'Society name',
            hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: AppColor.grey,
                ),
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
        ),
      );

  FlatButton _cancelButton() => FlatButton(
        color: AppColor.transparent,
        onPressed: () => {Navigator.pop(context)},
        child: Text(
          'Cancel',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColor.cautionColor),
        ),
      );

  FlatButton _addButton() => FlatButton(
        color: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            LayoutConstants.dimen_12.w,
          ),
        ),
        onPressed: ()  {
          AnalyticsUtil.trackEvent(eventName: 'Add new society button clicked');
          Navigator.pop(context);
          widget.onAdd(_societyNameTextController.text);
        },
        child: Text(
          'Add',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: AppColor.white),
        ),
      );
}
