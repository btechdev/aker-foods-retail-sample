import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/journey/orders/order_detail_items_list.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderDetailsScreen extends StatefulWidget {
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: _getBody(),
      );

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  SingleChildScrollView _getBody() => SingleChildScrollView(
    child: _getColumn(),
  );

  Column _getColumn() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
          child: _getTitleAndValue(context, 'Order ID', '34607'),
        ),
        SizedBox(height: LayoutConstants.dimen_8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
          child: _getTitleAndValue(context, 'Order Date', '6th Aug, 2020'),
        ),
        SizedBox(height: LayoutConstants.dimen_20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
          child: _getDeliveryDetailsContainerHeader('Delivery Details'),
        ),
        SizedBox(height: LayoutConstants.dimen_8.h),
        _getDeliveryDetailsContainer(
            '6th Aug, 2020', 'Xpress Delivery', 'Order Status: Delivered'),
        SizedBox(height: LayoutConstants.dimen_20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
          child: _getDeliveryDetailsContainerHeader('Delivery Address'),
        ),
        SizedBox(height: LayoutConstants.dimen_8.h),
        _getDeliveryDetailsContainer(
            'Suraj Saste', 'Nivedita Terrace', 'Contact Number: 88219212091'),
        SizedBox(height: LayoutConstants.dimen_20.h),
        _getBillDetails(),
        SizedBox(height: LayoutConstants.dimen_20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
          child: _getDeliveryDetailsContainerHeader('Items in this order'),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: OrderDetailsItemList(
            items: const ['Mango', 'Apple', 'Pumpkin'],
          ),
        ),
      ],
    );

  Row _getTitleAndValue(BuildContext context, String title, String value) =>
      Row(
        children: <Widget>[
          Text(
            '$title: ',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColor.grey,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      );

  Text _getDeliveryDetailsContainerHeader(String headerText) => Text(
        headerText,
        style: Theme.of(context).textTheme.bodyText1,
      );

  Container _getDeliveryDetailsContainer(
          String title, String subtitle, String extra) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        height: LayoutConstants.dimen_120.h,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w)),
        child: _getDeliveryDetailsContainerText(title, subtitle, extra),
      );

  Column _getDeliveryDetailsContainerText(
          String title, String subtitle, String extra) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: LayoutConstants.dimen_12.h),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(height: LayoutConstants.dimen_12.h),
          Text(
            extra,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Expanded(
            child: Container(),
          ),
        ],
      );

  Container _getBillDetails() => Container(
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        color: AppColor.white,
        child: _getDetails(context),
      );

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
            'Total Amount',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );

  Text _getHeaderText(BuildContext context) => Text(
        'Summary',
        style: Theme.of(context).textTheme.bodyText1,
      );

  Row _getPaymentSection(BuildContext context,
      {String title, String amount, Color color = AppColor.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: color),
        ),
        Text(
          amount,
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: color),
        ),
      ],
    );
  }
}
