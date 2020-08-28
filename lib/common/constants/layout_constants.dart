import 'package:flutter/material.dart';

import '../../presentation/theme/app_colors.dart';
import '../extensions/pixel_dimension_util_extensions.dart';

class LayoutConstants {
  LayoutConstants._();

  static double get primaryButtonHeight => 48.h;

  static double get profileInputTextFieldHeight => 52.h;
  static double get myAccountOptionCellHeight => 60.h;

  static BoxDecoration get inputBoxDecoration => BoxDecoration(
        border: Border.all(color: AppColor.black25, width: 1.w),
        borderRadius: BorderRadius.circular(12.w),
      );
}
