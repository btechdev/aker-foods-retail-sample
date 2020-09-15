import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/data/repositories/products_repository_impl.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/notify_me_button.dart';
import 'package:aker_foods_retail/presentation/widgets/product_info_price_widget.dart';
import 'package:flutter/material.dart';

class MyOrderOutOfStockCell extends StatefulWidget {
  final Function onDelete;
  final Function onNotify;

  MyOrderOutOfStockCell({this.onDelete, this.onNotify});

  @override
  _MyOrderOutOfStockCellState createState() => _MyOrderOutOfStockCellState();
}

class _MyOrderOutOfStockCellState extends State<MyOrderOutOfStockCell> {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        color: AppColor.orangeDark.withOpacity(0.10),
        shape: LayoutConstants.borderlessRoundedRectangle,
        child: Container(
          height: LayoutConstants.dimen_140.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_12.w,
            vertical: LayoutConstants.dimen_12.h,
          ),
          child: _productDetailsRow(context),
        ),
      );

  Row _productDetailsRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _productImageClippedRect(),
          Expanded(
            flex: 3,
            child: _productDetailsContainer(context),
          ),
          Expanded(
            flex: 2,
            child: _actionsColumn(context),
          )
        ],
      );

  ClipRRect _productImageClippedRect() => ClipRRect(
        borderRadius: LayoutConstants.defaultBorderRadius,
        child: Stack(
          children: <Widget>[
            _productImage(),
            _outOfStockOverlayContainer(),
          ],
        ),
      );

  Container _productDetailsContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: LayoutConstants.dimen_12.w),
        child: ProductInfoPrice(
          product: ProductsRepositoryImpl.dummyProducts[0],
        ),
      );

  Column _actionsColumn(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.delete, color: AppColor.black54),
            padding: EdgeInsets.zero,
            onPressed: widget.onDelete,
          ),
          NotifyMeButton(onPressed: widget.onNotify),
        ],
      );

  Image _productImage() => Image.asset(
        'assets/images/user-profile-vegies.jpeg',
        width: LayoutConstants.dimen_100.w,
        height: LayoutConstants.dimen_100.h,
        fit: BoxFit.cover,
      );

  Container _outOfStockOverlayContainer() => Container(
        width: LayoutConstants.dimen_100.w,
        height: LayoutConstants.dimen_100.h,
        color: AppColor.white54,
        alignment: Alignment.center,
        child: Container(
          width: LayoutConstants.dimen_100.w,
          height: LayoutConstants.dimen_24.h,
          color: AppColor.white,
          alignment: Alignment.center,
          child: Text(
            'Out of stock',
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: AppColor.black54,
                ),
          ),
        ),
      );
}
