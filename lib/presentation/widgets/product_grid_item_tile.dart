import 'package:aker_foods_retail/common/constants/app_constants.dart';
import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/order_item_counter.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/product_grid_discount_badge.dart';
import 'package:flutter/material.dart';

class ProductGridItemTile extends StatefulWidget {
  final ProductEntity product;

  const ProductGridItemTile({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductGridItemTileState();
}

class ProductGridItemTileState extends State<ProductGridItemTile> {
  int _itemCountInCart = 0;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
        color: AppColor.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.5, color: AppColor.black25),
          borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
        ),
        child: _getBody(context),
      );

  Column _getBody(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getItemImage(context),
          _getItemDetail(context),
        ],
      );

  Widget _getItemImage(BuildContext context) {
    if (widget.product.discountedPrice != null &&
        widget.product.discountedPrice > 0) {
      return Stack(
        children: [
          _productAvatarContainer(),
          ProductGridDiscountBadge(product: widget.product),
        ],
      );
    }
    return _productAvatarContainer();
  }

  Container _productAvatarContainer() => Container(
        alignment: Alignment.center,
        color: AppColor.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_16.h,
        ),
        child: CircleAvatar(
          radius: LayoutConstants.dimen_32.w,
          backgroundImage: const ExactAssetImage(
            'assets/images/user-profile-vegies.jpeg',
          ),
        ),
      );

  Container _getItemDetail(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_16.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: LayoutConstants.dimen_52.h,
              child: Text(
                widget.product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Text(
              '${widget.product.baseQuantity} ${widget.product.unit}',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: AppColor.black40,
                  ),
            ),
            SizedBox(height: LayoutConstants.dimen_8.h),
            _getProductPriceRow(),
            SizedBox(height: LayoutConstants.dimen_8.h),
            _itemCountInCart > 0
                ? _orderItemCounterWithContainer(context)
                : _buttonWithContainer(context),
          ],
        ),
      );

  Container _orderItemCounterWithContainer(BuildContext context) => Container(
        height: LayoutConstants.dimen_48.h,
        alignment: Alignment.center,
        child: OrderItemCounter(
          counterStart: _itemCountInCart,
          onCountChanged: (count) {
            setState(() {
              _itemCountInCart = count;
            });
          },
        ),
      );

  Container _buttonWithContainer(BuildContext context) => Container(
        height: LayoutConstants.dimen_48.h,
        alignment: Alignment.centerRight,
        child: FlatButton(
          color: AppColor.primaryColor,
          onPressed: _addOneItemOfProduct,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LayoutConstants.dimen_8.w),
          ),
          child: Text(
            'Add'.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );

  void _addOneItemOfProduct() {
    setState(() {
      ++_itemCountInCart;
    });
  }

  Widget _getProductPriceRow() {
    /*final double productMrp = widget.product.price ?? 0;
    final double priceDiscountValue =
        productMrp * (widget.product.discount ?? 0);

    final double productPrice =
        priceDiscountValue > 0 ? productMrp - priceDiscountValue : productMrp;

    final List<Widget> rowChildren = List()
      ..add(_productPriceText(productPrice));
    if (priceDiscountValue > 0) {
      rowChildren
        ..add(SizedBox(width: LayoutConstants.dimen_4.w))
        ..add(_productMrpFlexibleText(productMrp));
    }*/
    final double productMrp = widget.product.price ?? 0;
    final double productDiscountPrice = widget.product.discountedPrice ?? 0;
    final double priceDiscountValue = productMrp - productDiscountPrice;

    final List<Widget> rowChildren = List()
      ..add(_productPriceText(productDiscountPrice));
    if (priceDiscountValue > 0) {
      rowChildren
        ..add(SizedBox(width: LayoutConstants.dimen_4.w))
        ..add(_productMrpFlexibleText(productMrp));
    }
    return Row(children: rowChildren);
  }

  Text _productPriceText(double productPrice) => Text(
        '${AppConstants.rupeeSymbol} $productPrice',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: AppColor.orangeDark,
              fontWeight: FontWeight.w600,
            ),
      );

  Flexible _productMrpFlexibleText(double productMrp) => Flexible(
        child: Text(
          '${AppConstants.rupeeSymbol} $productMrp',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2.copyWith(
                color: AppColor.black40,
                decoration: TextDecoration.lineThrough,
              ),
        ),
      );
}
