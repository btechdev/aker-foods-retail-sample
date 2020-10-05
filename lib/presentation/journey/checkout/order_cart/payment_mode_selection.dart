import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/payment_mode.dart';
import 'package:flutter/material.dart';

class PaymentModeSelection extends StatefulWidget {
  final PaymentMode selectedPaymentMode;
  final Function(PaymentMode) onPaymentSelection;

  PaymentModeSelection({
    @required this.selectedPaymentMode,
    @required this.onPaymentSelection,
  });

  @override
  _PaymentModeSelectionState createState() => _PaymentModeSelectionState();
}

class _PaymentModeSelectionState extends State<PaymentModeSelection> {
  PaymentMode _paymentMode;

  @override
  void initState() {
    super.initState();
    _paymentMode = widget.selectedPaymentMode ?? PaymentMode.cashOnDelivery;
  }

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
          _expandedRadioListTile('Online', PaymentMode.online),
          _expandedRadioListTile(
              'Cash on Delivery', PaymentMode.cashOnDelivery),
        ],
      );

  Expanded _expandedRadioListTile(String buttonText, PaymentMode mode) =>
      Expanded(
        child: RadioListTile<PaymentMode>(
          title: Text(buttonText),
          value: mode,
          groupValue: _paymentMode,
          onChanged: (PaymentMode mode) {
            setState(() {
              _paymentMode = mode;
            });
            widget.onPaymentSelection(_paymentMode);
          },
        ),
      );
}
