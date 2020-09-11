import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/journey/user/address/change_address_mode_selection_bottom_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderDeliveryAddressSelection extends StatefulWidget {
  OrderDeliveryAddressSelection({Key key}) : super(key: key);

  @override
  _OrderDeliveryAddressSelectionState createState() =>
      _OrderDeliveryAddressSelectionState();
}

class _OrderDeliveryAddressSelectionState
    extends State<OrderDeliveryAddressSelection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: LayoutConstants.dimen_16.w,
          top: LayoutConstants.dimen_16.h,
          right: LayoutConstants.dimen_16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getHeaderText(context),
              GestureDetector(
                onTap: () => _getLocationSelectionBottomSheet(context),
                child: Text(
                  'Choose Address',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
          SizedBox(
            height: LayoutConstants.dimen_8.h,
          ),
          Text('Adress', style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }

  Text _getHeaderText(BuildContext context) => Text(
        'Select Delivery Type',
        style: Theme.of(context).textTheme.headline6,
      );

  Future _getLocationSelectionBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(LayoutConstants.dimen_12.w),
          topRight: Radius.circular(LayoutConstants.dimen_12.w),
        ),
      ),
      builder: (BuildContext context) =>
          ChangeAddressModeSelectionBottomSheet(),
    );
  }
}
