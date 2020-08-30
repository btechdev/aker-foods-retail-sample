import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

Material wrapWithMaterialInkWellCard({
  @required BuildContext context,
  @required Widget child,
  Key cardKey,
  Color cardColor,
  Color highlightColor,
  BorderRadius borderRadius,
  GestureTapCallback onTap,
}) =>
    Material(
      key: cardKey,
      type: MaterialType.card,
      color: cardColor ?? AppColor.white,
      borderRadius: borderRadius,
      child: InkWell(
        highlightColor: highlightColor ?? Theme.of(context).highlightColor,
        borderRadius: borderRadius,
        onTap: onTap,
        child: child,
      ),
    );
