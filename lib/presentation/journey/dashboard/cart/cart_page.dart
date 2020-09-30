import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/constants/payment_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/domain/entities/cart_product_entity.dart';
import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/bill_details_widget.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_delivery_address.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_delivery_selection.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/payment_type_selection.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/circular_loader_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/coupon_promo_code_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_list_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String appliedCouponPromoCode = '';
  int _paymentType = PaymentTypeConstants.cashOnDelivery;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _getAppBar(),
        body: _getBody(),
        bottomNavigationBar: _cartBottomWidget(),
      );

  AppBar _getAppBar() => AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: false,
        elevation: LayoutConstants.dimen_1,
        backgroundColor: AppColor.white,
      );

  Widget _getBody() => BlocConsumer<CartBloc, CartState>(
        cubit: BlocProvider.of<CartBloc>(context)..add(ValidateCartEvent()),
        listener: _cartBlocListener,
        builder: _cartBlocBuilderWidget,
      );

  void _cartBlocListener(BuildContext context, CartState state) {
    debugPrint('CartBloc => listener: $state');
  }

  Widget _cartBlocBuilderWidget(BuildContext context, CartState state) {
    if (state is CartLoadingState) {
      return const CircularLoaderWidget();
    } else if (state is CartLoadedState ||
        state is NotifyUserAboutProductFailure) {
      return _cartBlocBuilderBody(state);
    }
    // TODO(Bhushan): Fix this issue of go to home button not showing
    debugPrint('Building empty cart container');
    return _emptyCartIndicatorContainer();
  }

  Widget _cartBlocBuilderBody(CartLoadedState state) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: _cartProductsList(state.cartEntity?.products),
            ),
            SizedBox(height: LayoutConstants.dimen_4.h),
            const Divider(),
            _couponPromoCodeInkWell(),
            const Divider(),
            BillDetailsWidget(
              billingEntity: state.cartEntity.billingEntity,
              showErrorMessage: state.hasOutOfStockProducts ?? false,
              message: state.message ?? '',
            ),
            const Divider(),
            OrderDeliverySelection(),
            const Divider(),
            PaymentTypeSelection(
              onPaymentSelection: (typeInt) => _paymentType = typeInt,
            ),
            const Divider(),
            OrderDeliveryAddressSelection(
              onAddressSelection: (id) {
                if (id is int) {
                  //_addressId = id;
                  // TODO(Bhushan): Check if this is needed
                }
              },
            ),
            SizedBox(height: LayoutConstants.dimen_32.h)
          ],
        ),
      );

  Widget _cartProductsList(List<CartProductEntity> cartProducts) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: LayoutConstants.dimen_8.w,
          vertical: LayoutConstants.dimen_8.h,
        ),
        itemCount: cartProducts?.length ?? 0,
        itemBuilder: (context, index) {
          final cartProduct = cartProducts[index];
          if (cartProduct?.product?.isInStock == true) {
            return InStockProductListTile(cartProduct: cartProduct);
          }
          return OutOfStockProductListTile(
            cartProduct: cartProduct,
            onNotify: () => BlocProvider.of<CartBloc>(context).add(
                NotifyUserAboutProductEvent(
                    productEntity: cartProduct.product)),
            onDelete: () => BlocProvider.of<CartBloc>(context).add(
              RemoveProductFromCartEvent(
                productEntity: cartProduct.product,
                needsCartValidation: true,
              ),
            ),
          );
        },
      );

  InkWell _couponPromoCodeInkWell() => InkWell(
        onTap: _navigateToCouponPromoCodeSelection,
        child: CouponPromoCodeWidget(
          code: appliedCouponPromoCode,
          onRemoveAppliedCode: _removeAppliedCouponPromoCode,
        ),
      );

  Future<void> _navigateToCouponPromoCodeSelection() async {
    final code =
        await Navigator.pushNamed(context, RouteConstants.applyCouponPromoCode);
    if (code != null && code is CouponEntity) {
      setState(() {
        appliedCouponPromoCode = code.code;
      });
    }
  }

  void _removeAppliedCouponPromoCode() {
    setState(() {
      appliedCouponPromoCode = '';
    });
  }

  Widget _cartBottomWidget() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          return _buttonWithContainer();
        }
        return Container();
      },
    );
  }

  Container _buttonWithContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        margin: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_16.h),
        child: RaisedButton(
          color: AppColor.primaryColor,
          onPressed: () => BlocProvider.of<CartBloc>(context).add(
            CreateOrderCartEvent(paymentType: _paymentType),
          ),
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

  Container _emptyCartIndicatorContainer() => Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: LayoutConstants.dimen_64.w,
          height: LayoutConstants.dimen_48.h,
          child: RaisedButton(
            color: AppColor.primaryColor,
            onPressed: () => {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LayoutConstants.dimen_12.w),
            ),
            child: Text(
              'Go to Home',
              style: Theme.of(context).textTheme.button.copyWith(
                    color: AppColor.white,
                  ),
            ),
          ),
        ),
      );
}
