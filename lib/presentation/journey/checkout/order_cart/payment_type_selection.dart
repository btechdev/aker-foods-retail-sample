import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

enum PaymentSelectionType { cod, online }

class PaymentTypeSelection extends StatefulWidget {
  @override
  _PaymentTypeSelectionState createState() => _PaymentTypeSelectionState();
}

class _PaymentTypeSelectionState extends State<PaymentTypeSelection> {
  var _type = PaymentSelectionType.online;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: LayoutConstants.dimen_16.w, top: LayoutConstants.dimen_16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeaderText(context),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RadioListTile<PaymentSelectionType>(
                    title: const Text('Online'),
                    value: PaymentSelectionType.online,
                    groupValue: _type,
                    onChanged: (PaymentSelectionType value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<PaymentSelectionType>(
                    title: const Text('Cash on Delivery'),
                    value: PaymentSelectionType.cod,
                    groupValue: _type,
                    onChanged: (PaymentSelectionType value) {
                      setState(() {
                        _type = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _getHeaderText(BuildContext context) => Text(
        'Payment',
        style: Theme.of(context).textTheme.headline6,
      );
}
