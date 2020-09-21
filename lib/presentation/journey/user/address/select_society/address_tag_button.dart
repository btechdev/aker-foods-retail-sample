import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';

enum AddressTagType { home, office, other }

class AddressTagButton extends StatelessWidget {
  final String title;
  final AddressTagType type;
  final VoidCallback onSelect;
  final bool isSelected;

  AddressTagButton({this.type, this.title, this.onSelect, this.isSelected});

  @override
  Widget build(BuildContext context) => FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isSelected
                  ? AppColor.transparent
                  : AppColor.primaryColorDark),
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_20.w),
        ),
        onPressed: onSelect,
        color: isSelected ? AppColor.primaryColor : AppColor.white,
        child: Text(
          title,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppColor.white : AppColor.primaryColorDark,
              ),
        ),
      );
}
