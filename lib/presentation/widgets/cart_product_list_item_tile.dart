import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/cart_product_entity.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/order_item_counter.dart';
import 'package:aker_foods_retail/presentation/widgets/product_info_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductListItemTile extends StatefulWidget {
  final bool onlyShowingDetails;
  final CartProductEntity cartProduct;

  CartProductListItemTile({
    Key key,
    this.cartProduct,
    this.onlyShowingDetails = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartProductListItemTileState();
}

class _CartProductListItemTileState extends State<CartProductListItemTile> {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 0,
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
          if (!widget.onlyShowingDetails)
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: _productQuantityCountManager(),
              ),
            )
        ],
      );

  ClipRRect _productImageClippedRect() => ClipRRect(
        borderRadius: LayoutConstants.defaultBorderRadius,
        child: _productImage(),
      );

  Image _productImage() => Image.network(
        widget.cartProduct?.product?.imageUrl ??
            'https://picsum.photos/id/1080/100/100',
        width: LayoutConstants.dimen_100.w,
        height: LayoutConstants.dimen_100.h,
        fit: BoxFit.cover,
      );

  Container _productDetailsContainer(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: LayoutConstants.dimen_12.w),
        child: ProductInfoPrice(product: widget.cartProduct?.product),
      );

  ProductQuantityCountManager _productQuantityCountManager() =>
      ProductQuantityCountManager(
        counterStart: widget.cartProduct?.count ?? 0,
        onIncrementQuantity: (count) {
          BlocProvider.of<CartBloc>(context).add(
            AddProductToCartEvent(
              needsCartValidation: true,
              productEntity: widget.cartProduct.product,
            ),
          );
        },
        onDecrementQuantity: (count) {
          BlocProvider.of<CartBloc>(context).add(
            RemoveProductFromCartEvent(
              needsCartValidation: true,
              productEntity: widget.cartProduct.product,
            ),
          );
        },
      );
}
