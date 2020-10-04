import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BillDetailsWidget extends StatefulWidget {
  final BillingEntity billingEntity;
  final bool showErrorMessage;
  final String message;

  const BillDetailsWidget({
    Key key,
    @required this.billingEntity,
    this.showErrorMessage,
    this.message,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BillDetailsWidgetState();
}

class BillDetailsWidgetState extends State<BillDetailsWidget> {
  String _textWithRupeePrefix(double value) =>
      '${AppConstants.rupeeSymbol} $value';

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(LayoutConstants.dimen_16.w),
        child: _getBody(),
      );

  Widget _getBody() {
    if (widget.showErrorMessage == true) {
      return _errorContainer();
    } else if (widget.billingEntity == null) {
      return Container();
    } else {
      return _billDetailsColumn();
    }
  }

  Container _errorContainer() => Container(
        alignment: Alignment.center,
        child: Text(
          widget.message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.cautionColor,
              ),
        ),
      );

  Column _billDetailsColumn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getHeaderText(),
          SizedBox(height: LayoutConstants.dimen_12.h),
          _billDetailsRow(
            descriptionText: 'Cart total value',
            amountText: _textWithRupeePrefix(widget.billingEntity.totalAmount),
          ),
          SizedBox(height: LayoutConstants.dimen_8.h),
          ..._getDiscountDetailsWidgets(),
          const Divider(),
          SizedBox(height: LayoutConstants.dimen_12.h),
          _finalAmountToPayRow(widget.billingEntity.totalAmount),
        ],
      );

  Text _getHeaderText() => Text(
        'Bill Details',
        style: Theme.of(context).textTheme.headline6,
      );

  Row _billDetailsRow({
    String descriptionText,
    String amountText,
    Color textColor = AppColor.black,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            descriptionText,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: textColor,
                ),
          ),
          Text(
            amountText,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: textColor,
                ),
          ),
        ],
      );

  List<Widget> _getDiscountDetailsWidgets() {
    final List<Widget> widgets = [];
    if (widget.billingEntity.isCouponApplied ?? false) {
      widgets
        ..add(_billDetailsRow(
          descriptionText: 'Coupon discount amount',
          amountText: '- '
              '${_textWithRupeePrefix(widget.billingEntity.couponAmountSaved)}',
          textColor: AppColor.primaryColor,
        ))
        ..add(SizedBox(height: LayoutConstants.dimen_8.h));
    }

    final otherDiscountAmount = widget.billingEntity.totalAmount -
        widget.billingEntity.discountedAmount;
    if (otherDiscountAmount > 0) {
      widgets
        ..add(_billDetailsRow(
          descriptionText: 'Other discount amount',
          amountText: '- ${_textWithRupeePrefix(otherDiscountAmount)}',
          textColor: AppColor.primaryColor,
        ))
        ..add(SizedBox(height: LayoutConstants.dimen_8.h));
    }

    final deliveryCharge =
        (widget.billingEntity.deliveryCharges ?? 0).toDouble();
    widgets
      ..add(_billDetailsRow(
        descriptionText: 'Total amount saved',
        amountText: '${_textWithRupeePrefix(widget.billingEntity.totalSaved)}',
        textColor: AppColor.primaryColor,
      ))
      ..add(SizedBox(height: LayoutConstants.dimen_8.h))
      ..add(_billDetailsRow(
        descriptionText: 'Delivery charge',
        amountText: '${_textWithRupeePrefix(deliveryCharge)}',
      ));
    return widgets;
  }

  Row _finalAmountToPayRow(double amount) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'To Pay',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            _textWithRupeePrefix(amount),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      );
}
