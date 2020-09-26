import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/bill_details_widget.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_delivery_address.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_delivery_selection.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_item_list.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/payment_type_selection.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/referral_code_container.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class CheckoutOrderScreen extends StatefulWidget {
  CheckoutOrderScreen({Key key}) : super(key: key);

  @override
  _CheckoutOrderScreenState createState() => _CheckoutOrderScreenState();
}

class _CheckoutOrderScreenState extends State<CheckoutOrderScreen> {
  List<String> items = ['abc', 'def', 'ghi'];
  String referralCode = '';
  bool isReferralCodeApplied = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: KeyboardAvoider(
          autoScroll: true,
          child: _getBody(),
        ),
        bottomNavigationBar: _buttonWithContainer(),
      );

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
      child: _getColumn(),
    );
  }

  Column _getColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            fit: FlexFit.loose,
            child: OrderItemList(
              items: items,
              onDecreased: (index, value) => {
                debugPrint('$index $value'),
                if (value == 0) {items.removeAt(index), setState(() {})}
              },
              onIncreased: (index, value) => {
                debugPrint('$index $value'),
              },
            )),
        _getReferralContainer(),
        //BillDetailsWidget(),
        const Divider(),
        OrderDeliverySelection(),
        const Divider(),
//        PaymentTypeSelection(),
        const Divider(),
        OrderDeliveryAddressSelection(),
        SizedBox(
          height: LayoutConstants.dimen_32.h,
        )
      ],
    );
  }

  InkWell _getReferralContainer() => InkWell(
        onTap: _navigateToReferralCodeSelection,
        child: Container(
          color: AppColor.grey25,
          height: LayoutConstants.dimen_60.h,
          padding: EdgeInsets.symmetric(
              horizontal: LayoutConstants.dimen_16.w,
              vertical: LayoutConstants.dimen_8.h),
          child: ReferralCodeContainer(
            isReferralCodeApplied: isReferralCodeApplied,
            referralCode:
                referralCode.isEmpty ? 'Apply Referral Code' : referralCode,
            onRemoveReferralCode: _removeReferralCode,
          ),
        ),
      );

  Future<void> _navigateToReferralCodeSelection() async {
    final code =
        await Navigator.pushNamed(context, RouteConstants.applyCouponPromoCode);
    if (code is CouponEntity) {
      if (code != null) {
        setState(() {
          isReferralCodeApplied = true;
          referralCode = code.code;
        });
      }
    }
  }

  void _removeReferralCode() {
    setState(() {
      referralCode = '';
      isReferralCodeApplied = false;
    });
  }

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Cart',
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
          onPressed: () => {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
          ),
          child: Text(
            'Proceed to pay',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );
}
