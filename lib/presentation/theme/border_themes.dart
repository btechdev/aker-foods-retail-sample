import 'package:flutter/material.dart';

import '../../common/extensions/pixel_dimension_util_extensions.dart';
import 'app_colors.dart';

class AppBorderTheme {
  static RoundedRectangleBorder primaryButtonBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.w),
  );

  static RoundedRectangleBorder dialogThemeShapeBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(13.w),
    side: const BorderSide(color: AppColor.white),
  );
}
