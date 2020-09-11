import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class WalletTransactionsScreen extends StatefulWidget {
  @override
  _WalletTransactionsScreenState createState() =>
      _WalletTransactionsScreenState();
}

class _WalletTransactionsScreenState extends State<WalletTransactionsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
      bottomNavigationBar: _buttonWithContainer(),
    );
  }

  AppBar _getAppBar() => AppBar(
        title: Text(
          'My Transactions',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  Container _buttonWithContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        margin: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_16.h),
        child: RaisedButton(
          color: AppColor.primaryColor,
          onPressed: () => {
            Navigator.pushNamed(context, RouteConstants.myWalletCashbackOffers),
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          ),
          child: Text(
            'Add credit balance',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );

  Container _getBody() => Container(
        child: Column(
          children: <Widget>[
            _getCurrentCreditContainer(),
            Expanded(
              child: _getTransactionsContainer(),
            ),
          ],
        ),
      );

  Container _getCurrentCreditContainer() => Container(
        margin: EdgeInsets.symmetric(
            vertical: LayoutConstants.dimen_12.h,
            horizontal: LayoutConstants.dimen_16.w),
        padding: EdgeInsets.all(LayoutConstants.dimen_12.w),
        height: LayoutConstants.dimen_90.h,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Current Credit',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: AppColor.white,
                      ),
                ),
                Text(
                  'Rs 50',
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: AppColor.white,
                      ),
                ),
              ],
            ),
            Icon(
              Icons.credit_card,
              size: LayoutConstants.dimen_40.w,
              color: AppColor.white,
            ),
          ],
        ),
      );

  Container _getTransactionsContainer() => Container(
        margin: EdgeInsets.symmetric(
            vertical: LayoutConstants.dimen_12.h,
            horizontal: LayoutConstants.dimen_16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Transaction History',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: LayoutConstants.dimen_16.h,
            ),
            Flexible(fit: FlexFit.loose, child: _getListView()),
          ],
        ),
      );

  ListView _getListView() => ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
          height: LayoutConstants.dimen_120.h,
          padding: EdgeInsets.symmetric(
            vertical: LayoutConstants.dimen_12.h,
          ),
          child: _getDetailsContainer(),
        ),
      );

  Container _getDetailsContainer() => Container(
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          boxShadow: [
            BoxShadow(
              blurRadius: LayoutConstants.dimen_4.w,
              color: AppColor.grey,
            ),
          ],
          color: AppColor.white,
        ),
        child: _getTransactionContent(),
      );

  Row _getTransactionContent() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: PixelDimensionUtil().uiWidthPx * .60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Title, Title, Title, Title, Title,'
                  'Title, Title, Title, Title, Title,'
                  'Title, Title, Title, Title, Title',
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: LayoutConstants.dimen_2.h,
                ),
                Text(
                  'subtitle',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: AppColor.grey, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          Container(
            child: Text(
              '+ Rs 50',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: AppColor.primaryColor,
                  ),
              textAlign: TextAlign.end,
            ),
          )
        ],
      );
}
