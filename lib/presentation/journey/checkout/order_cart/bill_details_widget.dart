import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class BillDetailsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
      child: _getDetails(context),
    );
  }

  Column _getDetails(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeaderText(context),
          SizedBox(height: LayoutConstants.dimen_12.h),
          _getPaymentSection(
            context,
            title: '1 x Total Items Price',
            amount: 'Rs 22',
          ),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _getPaymentSection(
            context,
            title: '50% off upto Rs 75',
            amount: '- Rs 11',
            color: AppColor.primaryColor,
          ),
          SizedBox(height: LayoutConstants.dimen_8.h),
          _getPaymentSection(
            context,
            title: 'Delivery Charges',
            amount: 'Rs 50',
          ),
          SizedBox(height: LayoutConstants.dimen_8.h),
          const Divider(),
          SizedBox(height: LayoutConstants.dimen_12.h),
          _getTotalPayment(context, 'Rs 61'),
          SizedBox(height: LayoutConstants.dimen_8.h),
        ],
      );

  Row _getTotalPayment(BuildContext context, String amount) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'To Pay',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );

  Text _getHeaderText(BuildContext context) => Text(
        'Bill Details',
        style: Theme.of(context).textTheme.headline6,
      );

  Row _getPaymentSection(BuildContext context,
      {String title, String amount, Color color = AppColor.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
        ),
        Text(
          amount,
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
        ),
      ],
    );
  }
}
