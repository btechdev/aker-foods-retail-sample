import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

enum OrderDeliveryMethod { scheduled, express }

class OrderDeliverySelection extends StatefulWidget {
  OrderDeliverySelection({Key key}) : super(key: key);

  @override
  _OrderDeliverySelectionState createState() => _OrderDeliverySelectionState();
}

class _OrderDeliverySelectionState extends State<OrderDeliverySelection> {
  var _deliveryMethod = OrderDeliveryMethod.scheduled;

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
          _getHeaderText(context),
          SizedBox(
            height: LayoutConstants.dimen_8.h,
          ),
          _getButtonContainer(context),
        ],
      ),
    );
  }

  Container _getButtonContainer(BuildContext context) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _getExpressButton(context),
            _getScheduledButton(context),
          ],
        ),
      );

  FlatButton _getExpressButton(BuildContext context) => FlatButton(
        onPressed: () => {
          Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
            text: 'Coming Soon',
            type: CustomSnackBarType.error,
            position: CustomSnackBarPosition.top,
          ))
        },
        padding: EdgeInsets.all(LayoutConstants.dimen_8.w),
        color: _deliveryMethod == OrderDeliveryMethod.express
            ? AppColor.primaryColor
            : AppColor.transparent,
        child: Column(
          children: [
            Icon(
              Icons.ac_unit,
              color: _deliveryMethod == OrderDeliveryMethod.express
                  ? AppColor.white
                  : AppColor.black,
            ),
            Text(
              'Express',
              style: Theme.of(context).textTheme.caption.copyWith(
                  color: _deliveryMethod == OrderDeliveryMethod.express
                      ? AppColor.white
                      : AppColor.black),
            ),
          ],
        ),
      );

  FlatButton _getScheduledButton(BuildContext context) => FlatButton(
        onPressed: () => {
          setState(() {
            _deliveryMethod = OrderDeliveryMethod.scheduled;
          })
        },
        padding: EdgeInsets.all(LayoutConstants.dimen_8.w),
        color: _deliveryMethod == OrderDeliveryMethod.scheduled
            ? AppColor.primaryColor
            : AppColor.transparent,
        child: Column(
          children: [
            Icon(Icons.calendar_today,
                color: _deliveryMethod == OrderDeliveryMethod.scheduled
                    ? AppColor.white
                    : AppColor.black),
            Text(
              'Scheduled',
              style: Theme.of(context).textTheme.caption.copyWith(
                  color: _deliveryMethod == OrderDeliveryMethod.scheduled
                      ? AppColor.white
                      : AppColor.black),
            ),
          ],
        ),
      );

  Text _getHeaderText(BuildContext context) => Text(
        'Select Delivery Type',
        style: Theme.of(context).textTheme.headline6,
      );
}
