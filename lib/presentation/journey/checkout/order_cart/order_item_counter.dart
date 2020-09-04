import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../../common/extensions/pixel_dimension_util_extensions.dart';

class OrderItemCounter extends StatefulWidget {
  const OrderItemCounter({
    Key key,
  }) : super(key: key);

  @override
  _OrderItemCounterState createState() => _OrderItemCounterState();
}

class _OrderItemCounterState extends State {
  int _currentAmount = 0;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _currentAmount -= 1;
              });
            },
            child: _getButtonContainer(icon: Icons.remove),
          ),
          Text(
            '$_currentAmount',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentAmount += 1;
              });
            },
            child: _getButtonContainer(icon: Icons.add),
          ),
        ],
      );

  Container _getButtonContainer({IconData icon}) => Container(
        padding: EdgeInsets.all(LayoutConstants.dimen_5.w),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w)),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      );
}
