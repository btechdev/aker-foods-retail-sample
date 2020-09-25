import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';
import 'package:aker_foods_retail/domain/entities/cash_offer_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_event.dart';
import 'package:aker_foods_retail/presentation/journey/wallet/bloc/user_transaction_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/extensions/pixel_dimension_util_extensions.dart';

class WalletCashbackOffersScreen extends StatefulWidget {
  @override
  _WalletCashbackOffersScreenState createState() =>
      _WalletCashbackOffersScreenState();
}

class _WalletCashbackOffersScreenState
    extends State<WalletCashbackOffersScreen> {
  UserTransactionBloc userTransactionBloc;
  List<bool> _checkBox;

  void _resetOtherCheckBoxes(int index) {
    for (var i = 0; i < _checkBox.length; i++) {
      if (i != index) {
        _checkBox[i] = false;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkBox = [];
    userTransactionBloc = Injector.resolve<UserTransactionBloc>()
      ..add(FetchUserCashOffersEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: BlocProvider<UserTransactionBloc>(
          create: (context) => userTransactionBloc, child: _getBody()),
    );
  }

  Column _getBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getHeaderText(),
          _getWrappedOffersWithBloc(),
          _getButtons(),
        ],
      );

  Padding _getHeaderText() => Padding(
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        child: Text(
          'Offers',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );

  BlocBuilder _getWrappedOffersWithBloc() =>
      BlocBuilder<UserTransactionBloc, UserTransactionState>(
        builder: (context, state) {
          if (state is CashOfferFetchSuccessfulState) {
            for (var i = 0; i < state.cashOffers.length; i++) {
              _checkBox.add(false);
            }
            return _getListOfOffers(state.cashOffers);
          } else {
            return Container();
          }
        },
      );

  Container _getListOfOffers(List<CashOfferEntity> offers) {
    return Container(
      height: PixelDimensionUtil().uiHeightPx * 0.3,
      padding: EdgeInsets.only(
          left: LayoutConstants.dimen_16.w,
          right: LayoutConstants.dimen_16.w,
          top: LayoutConstants.dimen_8.w),
      child: _getOfferList(offers),
    );
  }

  GridView _getOfferList(List<CashOfferEntity> offers) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: LayoutConstants.dimen_8.w,
          mainAxisSpacing: LayoutConstants.dimen_16.h,
          childAspectRatio: LayoutConstants.dimen_2.w,
        ),
        itemBuilder: (context, index) => Card(
          child: Container(
              padding: EdgeInsets.only(left: LayoutConstants.dimen_8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${AppConstants.rupeeSymbol} ${offers[index].amount}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Checkbox(
                        onChanged: (value) => {
                          setState(() {
                            _checkBox[index] = !_checkBox[index];
                            _resetOtherCheckBoxes(index);
                          })
                        },
                        value: _checkBox[index],
                      )
                    ],
                  ),
                  Text(
                    '${AppConstants.rupeeSymbol} ${offers[index].cashBack}'
                    ' cashback',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              )),
        ),
        itemCount: offers.length,
      );

  Padding _getButtons() => Padding(
        padding: EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_16.w),
        child: Row(
          children: <Widget>[
            FlatButton(
              onPressed: () => {},
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: AppColor.primaryColor,
                    width: LayoutConstants.dimen_1.w,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
              ),
              child: Text(
                'Recharge with amount',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            SizedBox(
              width: LayoutConstants.dimen_30.w,
            ),
            Expanded(
              child: FlatButton(
                onPressed: () => {
                  Navigator.pushNamed(context, RouteConstants.myWalletAddMoney),
                },
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColor.primaryColor,
                      width: LayoutConstants.dimen_1.w,
                      style: BorderStyle.solid),
                  borderRadius:
                      BorderRadius.circular(LayoutConstants.dimen_8.w),
                ),
                child: Text(
                  'Add coins',
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
          ],
        ),
      );

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Add Money',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );
}
