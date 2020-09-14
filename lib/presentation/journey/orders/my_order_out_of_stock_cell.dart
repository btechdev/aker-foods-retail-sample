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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        ),
        child: Container(
          height: LayoutConstants.dimen_140.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_8.h,
          ),
          child: _productDetailsRow(context),
        ),
      );

  Row _productDetailsRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: _productImageClippedRect(),
          ),
          Expanded(
            flex: 1,
            child: _productDetailsContainer(context),
          ),
          Expanded(
            flex: 1,
            child: _actionsColumn(context),
          )
        ],
      );

  /*Container _productDetailsContainer(BuildContext context) => Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _productImageClippedRect(),
            SizedBox(width: LayoutConstants.dimen_12.w),
            ProductInfoPrice(product: ProductsRepositoryImpl.dummyProducts[0]),
            //_getItemPriceQuantityContainer(context)
          ],
        ),
      );*/

  Container _productDetailsContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: LayoutConstants.dimen_12.w),
        child:
            ProductInfoPrice(product: ProductsRepositoryImpl.dummyProducts[0]),
      );

  Column _actionsColumn(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: AppColor.black54,
            ),
            onPressed: widget.onDelete,
          ),
          Container(
            padding: EdgeInsets.only(bottom: LayoutConstants.dimen_12.h),
            child: NotifyMeButton(onPressed: widget.onNotify),
          ),
        ],
      );

  ClipRRect _productImageClippedRect() => ClipRRect(
        borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
        child: Stack(
          children: <Widget>[
            _productImage(),
            _outOfStockOverlayContainer(),
          ],
        ),
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
                  color: AppColor.black87,
                ),
          ),
        ),
      );

  Column _getItemPriceQuantityContainer(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Onion',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '1 kg',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(height: LayoutConstants.dimen_16.h),
          Text(
            'Rs 22',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: AppColor.orangeDark,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      );
}
