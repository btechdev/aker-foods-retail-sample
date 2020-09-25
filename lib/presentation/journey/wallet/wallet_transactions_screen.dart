import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/date_utils.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/domain/entities/transaction_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_event.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class WalletTransactionsScreen extends StatefulWidget {
  final double currentWalletBalance;
  WalletTransactionsScreen({this.currentWalletBalance});

  @override
  _WalletTransactionsScreenState createState() =>
      _WalletTransactionsScreenState();
}

class _WalletTransactionsScreenState extends State<WalletTransactionsScreen> {
  UserTransactionBloc userTransactionBloc;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userTransactionBloc = Injector.resolve<UserTransactionBloc>()
      ..add(FetchUserTransactionsEvent());
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

  BlocProvider _getBody() => BlocProvider<UserTransactionBloc>(
        create: (context) => userTransactionBloc,
        child: BlocBuilder<UserTransactionBloc, UserTransactionState>(
          builder: _getBodyContainer,
        ),
      );

  Container _getBodyContainer(
      BuildContext context, UserTransactionState state) {
    return Container(
      child: Column(
        children: <Widget>[
          _getCurrentCreditContainer(),
          Expanded(
            child: _getTransactionsContainer(state),
          ),
        ],
      ),
    );
  }

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
                  '${AppConstants.rupeeSymbol} ${widget.currentWalletBalance}',
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

  Container _getTransactionsContainer(UserTransactionState state) => Container(
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
            SizedBox(height: LayoutConstants.dimen_16.h),
            Flexible(
              fit: FlexFit.loose,
              child: (state is TransactionFetchSuccessfulState)
                  ? _getListView(state)
                  : Container(),
            ),
          ],
        ),
      );

  ListView _getListView(TransactionFetchSuccessfulState state) {
    final _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          debugPrint('get next page');
        }
      }
    });

    return ListView.builder(
      itemCount: state.transactions.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          Container(
            height: LayoutConstants.dimen_130.h,
            padding: EdgeInsets.symmetric(
              vertical: LayoutConstants.dimen_12.h,
            ),
            child: _getDetailsContainer(state.transactions[index]),
          ),
    );
  }

  Container _getDetailsContainer(TransactionEntity item) => Container(
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
        child: _getTransactionContent(item),
      );

  Row _getTransactionContent(TransactionEntity item) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: PixelDimensionUtil.screenWidthDp * .55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: LayoutConstants.dimen_2.h,
                ),
                Text(
                  DateUtils.getFormatterDate(item.date),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: AppColor.grey, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          Container(
            child: item.transactionType == 'withdraw'
                ? _getDebitAmountText('${item.value}')
                : _getCreditAmountText('${item.value}'),
          )
        ],
      );

  Text _getCreditAmountText(String value) => Text(
        '+ ${AppConstants.rupeeSymbol} $value',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.primaryColor,
            ),
      );

  Text _getDebitAmountText(String value) => Text(
        '- ${AppConstants.rupeeSymbol} $value',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.orangeDark,
            ),
      );
}
