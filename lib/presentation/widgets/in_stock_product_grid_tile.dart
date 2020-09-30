import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/extensions/string_extensions.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/order_item_counter.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/product_grid_discount_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_info_price_widget.dart';

class InStockProductGridTile extends StatefulWidget {
  final ProductEntity product;
  final int productQuantityCountInCart;

  const InStockProductGridTile({
    Key key,
    @required this.product,
    this.productQuantityCountInCart = 0,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => InStockProductGridTileState();
}

class InStockProductGridTileState extends State<InStockProductGridTile> {
  int _itemCountInCart = 0;

  @override
  void initState() {
    super.initState();
    _itemCountInCart = widget.productQuantityCountInCart;
  }

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
          _productImageWithBadges(),
          _productInfoContainer(),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: LayoutConstants.dimen_12.w),
            child: _itemCountInCart > 0
                ? _orderItemCounterWithContainer(context)
                : _buttonWithContainer(context),
          ),
        ],
      );

  Widget _productImageWithBadges() {
    if (widget.product.discountedAmount != null &&
        widget.product.discountedAmount > 0) {
      return Stack(
        children: [
          _productAvatarContainer(),
          ProductGridDiscountBadge(product: widget.product),
        ],
      );
    }
    return _productAvatarContainer();
  }

  /*Container _productAvatarContainer() => Container(
        alignment: Alignment.center,
        color: AppColor.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_16.h,
        ),
        child: CircleAvatar(
          radius: LayoutConstants.dimen_32.w,
          backgroundColor: AppColor.white,
          backgroundImage: widget.product.imageUrl.isNotNullAndEmpty
              ? NetworkImage(widget.product.imageUrl)
              : const ExactAssetImage(
                  'assets/images/logo_transparent_background.png',
                ),
        ),
      );*/

  Container _productAvatarContainer() => Container(
        alignment: Alignment.center,
        color: AppColor.scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_16.h,
        ),
        child: _productImageClippedRect(),
      );

  ClipRRect _productImageClippedRect() => ClipRRect(
        borderRadius: LayoutConstants.defaultBorderRadius,
        child: _productImage(),
      );

  Image _productImage() {
    final imageWidth = LayoutConstants.dimen_100.w;
    final imageHeight = LayoutConstants.dimen_100.h;
    return widget.product.imageUrl.isNotNullAndEmpty
        ? Image.network(
            widget.product.imageUrl,
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          )
        : Image.asset(
            'assets/images/logo_transparent_background.png',
            width: imageWidth,
            height: imageHeight,
            fit: BoxFit.cover,
          );
  }

  Container _productInfoContainer() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_12.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        child: ProductInfoPrice(product: widget.product),
      );

  Container _orderItemCounterWithContainer(BuildContext context) => Container(
        height: LayoutConstants.dimen_48.h,
        alignment: Alignment.center,
        child: ProductQuantityCountManager(
          counterStart: _itemCountInCart,
          onIncrementQuantity: (count) {
            setState(() {
              _itemCountInCart = count;
            });
            BlocProvider.of<CartBloc>(context).add(
              AddProductToCartEvent(productEntity: widget.product),
            );
          },
          onDecrementQuantity: (count) {
            setState(() {
              _itemCountInCart = count;
            });
            BlocProvider.of<CartBloc>(context).add(
              RemoveProductFromCartEvent(productEntity: widget.product),
            );
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
    BlocProvider.of<CartBloc>(context).add(
      AddProductToCartEvent(productEntity: widget.product),
    );
  }
}
