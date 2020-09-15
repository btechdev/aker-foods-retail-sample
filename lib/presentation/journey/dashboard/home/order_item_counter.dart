import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderItemCounter extends StatefulWidget {
  final int counterStart;
  final Function(int count) onCountChanged;

  const OrderItemCounter({
    Key key,
    this.counterStart,
    @required this.onCountChanged,
  }) : super(key: key);

  @override
  _OrderItemCounterState createState() => _OrderItemCounterState();
}

class _OrderItemCounterState extends State<OrderItemCounter> {
  int _currentCount;

  @override
  void initState() {
    super.initState();
    _currentCount = widget.counterStart ?? 0;
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (_currentCount > 0) {
                  setState(() {
                    _currentCount -= 1;
                    widget.onCountChanged?.call(_currentCount);
                  });
                }
              },
              child: _getButtonContainer(Icons.remove),
            ),
            Text(
              '$_currentCount',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentCount += 1;
                  widget.onCountChanged?.call(_currentCount);
                });
              },
              child: _getButtonContainer(Icons.add),
            ),
          ],
        ),
      );

  Container _getButtonContainer(IconData iconData) => Container(
        width: LayoutConstants.dimen_36.w,
        height: LayoutConstants.dimen_36.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        ),
        child: Icon(iconData, color: Colors.white),
      );
}
