import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NotifyMeButton extends StatelessWidget {
  @required
  final VoidCallback onPressed;

  NotifyMeButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: LayoutConstants.dimen_32.h,
      child: FlatButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        shape: _roundedRectangleBorder(),
        child: Text(
          'Notify Me'.toUpperCase(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }

  RoundedRectangleBorder _roundedRectangleBorder() => RoundedRectangleBorder(
        side: BorderSide(
          color: AppColor.black54,
          style: BorderStyle.solid,
          width: LayoutConstants.dimen_1.w,
        ),
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
      );
}
