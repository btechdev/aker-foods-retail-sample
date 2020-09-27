import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/constants/payment_constants.dart';
import 'package:flutter/material.dart';

import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

enum PaymentSelectionType { cashOnDelivery, online }

class PaymentTypeSelection extends StatefulWidget {
  final Function(int) onPaymentSelection;

  PaymentTypeSelection({@required this.onPaymentSelection});

  @override
  _PaymentTypeSelectionState createState() => _PaymentTypeSelectionState();
}

class _PaymentTypeSelectionState extends State<PaymentTypeSelection> {
  var _type = PaymentSelectionType.cashOnDelivery;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: LayoutConstants.dimen_16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeaderText(),
          _radioTilesRow(),
        ],
      ),
    );
  }

  Text _getHeaderText() => Text(
        'Payment',
        style: Theme.of(context).textTheme.headline6,
      );

  Row _radioTilesRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _expandedRadioListTile('Online', PaymentSelectionType.online),
          _expandedRadioListTile(
              'Cash on Delivery', PaymentSelectionType.cashOnDelivery),
        ],
      );

  Expanded _expandedRadioListTile(
          String buttonText, PaymentSelectionType type) =>
      Expanded(
        child: RadioListTile<PaymentSelectionType>(
          title: Text(buttonText),
          value: type,
          groupValue: _type,
          onChanged: (PaymentSelectionType value) {
            setState(() {
              _type = value;
            });
            widget.onPaymentSelection(_typeInt());
          },
        ),
      );

  int _typeInt() {
    return _type == PaymentSelectionType.cashOnDelivery
        ? PaymentTypeConstants.cashOnDelivery
        : PaymentTypeConstants.online;
  }
}
