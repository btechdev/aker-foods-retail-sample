import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/coupons_bloc/coupons_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/coupons_bloc/coupons_state.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coupons_bloc/coupons_event.dart';

class ApplyReferralCodeScreen extends StatefulWidget {
  ApplyReferralCodeScreen({Key key}) : super(key: key);

  @override
  _ApplyReferralCodeScreenState createState() =>
      _ApplyReferralCodeScreenState();
}

class _ApplyReferralCodeScreenState extends State<ApplyReferralCodeScreen> {
  final _referralCodeController = TextEditingController();
  CouponsBloc cartBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = Injector.resolve<CouponsBloc>()..add(FetchCouponsEvent());
  }

  @override
  void dispose() {
    cartBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: BlocProvider<CouponsBloc>(
          create: (context) => cartBloc,
          child: _getBody(),
        ),
      );

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Apply a Promo/Referral Code',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  Column _getBody() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTextFieldWithApplyButton(context),
          SizedBox(height: LayoutConstants.dimen_30.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.dimen_16.w,
            ),
            child: Text('Available Promo Codes',
                style: Theme.of(context).textTheme.bodyText1),
          ),
          SizedBox(height: LayoutConstants.dimen_16.h),
          BlocBuilder<CouponsBloc, CouponsState>(
            builder: (context, state) {
              if (state is CouponsFetchSuccessState) {
                return _getPromoCodeList(context, state);
              } else {
                return Container();
              }
            },
          ),
        ],
      );

  Container _getTextFieldWithApplyButton(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          border: Border.all(
              color: AppColor.black25, width: LayoutConstants.dimen_1.w),
          color: AppColor.white,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _getPromocodeTextField(context),
            ),
            FlatButton(
              onPressed: () =>
                  {Navigator.pop(context, _referralCodeController.text)},
              child: Container(
                width: LayoutConstants.dimen_80.w,
                height: LayoutConstants.dimen_70.h,
                alignment: Alignment.center,
                child: Text(
                  'Apply'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppColor.primaryColor,
                      ),
                ),
              ),
            ),
          ],
        ),
      );

  ListView _getPromoCodeList(
          BuildContext context, CouponsFetchSuccessState state) =>
      ListView.builder(
        itemBuilder: (_, index) =>
            _getPromoCodeTile(context, state.coupons[index]),
        shrinkWrap: true,
        itemCount: state.coupons.length,
      );

  TextField _getPromocodeTextField(BuildContext context) => TextField(
        controller: _referralCodeController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: LayoutConstants.dimen_16.w),
          hintText: 'Enter promo/Referral Code',
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                color: AppColor.grey,
              ),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      );

  Container _getPromoCodeTile(BuildContext context, CouponEntity entity) =>
      Container(
        height: LayoutConstants.dimen_80.h,
        padding: EdgeInsets.only(
            left: LayoutConstants.dimen_16.w, top: LayoutConstants.dimen_16.h),
        color: AppColor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: LayoutConstants.dimen_30.h,
                  padding: EdgeInsets.symmetric(
                      horizontal: LayoutConstants.dimen_4.w),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(LayoutConstants.dimen_12.w),
                    color: AppColor.yellow,
                  ),
                  child: Text(
                    entity.code,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: LayoutConstants.dimen_8.h),
                Text(
                  entity.description,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            FlatButton(
              onPressed: () => {Navigator.pop(context, entity)},
              child: Container(
                width: LayoutConstants.dimen_80.w,
                height: LayoutConstants.dimen_70.h,
                alignment: Alignment.center,
                child: Text(
                  'Apply'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: AppColor.primaryColor,
                      ),
                ),
              ),
            ),
          ],
        ),
      );
}
