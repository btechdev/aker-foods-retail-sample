import 'dart:async';

import 'package:aker_foods_retail/common/constants/layout_constants.dart';
import 'package:aker_foods_retail/common/constants/payment_constants.dart';
import 'package:aker_foods_retail/common/extensions/pixel_dimension_util_extensions.dart';
import 'package:aker_foods_retail/common/injector/injector.dart';
import 'package:aker_foods_retail/common/utils/analytics_utils.dart';
import 'package:aker_foods_retail/domain/entities/cart_product_entity.dart';
import 'package:aker_foods_retail/domain/entities/coupon_entity.dart';
import 'package:aker_foods_retail/network/http/http_util.dart';
import 'package:aker_foods_retail/presentation/app/route_constants.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/bill_details_widget.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_delivery_address.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/order_delivery_selection.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/payment_mode_selection.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/payment_mode.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_bloc.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bloc/dashboard_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/bottom_navigation_bar_details.dart';
import 'package:aker_foods_retail/presentation/theme/app_colors.dart';
import 'package:aker_foods_retail/presentation/widgets/coupon_promo_code_widget.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:aker_foods_retail/presentation/widgets/in_stock_product_list_tile.dart';
import 'package:aker_foods_retail/presentation/widgets/out_of_stock_product_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String appliedCouponPromoCode = '';

  PaymentMode _paymentMode;
  int _addressId;
  Timer _orderPaymentVerificationPollingTimer;

  void _cartBlocListener(BuildContext context, CartState state) {
    debugPrint('CartBloc => Listener: $state');
    if (state is NavigatedToOrderListState) {
      _orderPaymentVerificationPollingTimer = state.timer;
      Navigator.pushNamed(context, RouteConstants.myOrders, arguments: true);
    }
  }

  @override
  void initState() {
    super.initState();
    AnalyticsUtil.trackScreen(screenName: 'Cart Page');
  }

  @override
  void dispose() {
    _orderPaymentVerificationPollingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<CartBloc, CartState>(
        cubit: BlocProvider.of<CartBloc>(context)..add(ValidateCartEvent()),
        listener: _cartBlocListener,
        builder: _cartBlocBuilderWidget,
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

  Widget _cartBlocBuilderWidget(BuildContext context, CartState state) {
    if (state is CartLoadingState) {
      return _loaderWithScaffold();
    }
    /*if (state is CartLoadingState && state.totalProductCount > 0) {
      return _cartDetailsWithScaffold(state, showLoader: true);
    }*/
    if (state is CartLoadedState) {
      appliedCouponPromoCode = state.cartEntity?.promoCode;
      return _cartDetailsWithScaffold(state);
    }
    if (state is CartEmptyState) {
      return _emptyCartIndicatorWithScaffold();
    }
    return Container();
  }

  Scaffold _loaderWithScaffold() => Scaffold(
        appBar: _getAppBar(),
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );

  Scaffold _emptyCartIndicatorWithScaffold() => Scaffold(
        appBar: _getAppBar(),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _emptyCartIndicatorWidgets(),
            ),
          ),
        ),
      );

  Scaffold _cartDetailsWithScaffold(CartState state,
          {bool showLoader = false}) =>
      Scaffold(
        appBar: _getAppBar(),
        bottomNavigationBar:
            showLoader ? Container() : _cartBottomWidget(state),
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _cartDetailsWidgets(state),
                ),
              ),
              if (showLoader)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: AppColor.black25),
                  child: const CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      );

  List<Widget> _cartDetailsWidgets(CartLoadedState state) => [
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
          showErrorMessage:
              state.hasInvalidPromoCodeApplied || state.hasOutOfStockProducts,
          message: state.message ?? HttpUtil.unknownError,
        ),
        const Divider(),
        OrderDeliverySelection(),
        const Divider(),
        PaymentModeSelection(
          selectedPaymentMode: PaymentModeExtension.fromInt(
            state.cartEntity.paymentMode ?? PaymentModeConstants.cashOnDelivery,
          ),
          onPaymentSelection: (mode) {
            _paymentMode = mode;
            BlocProvider.of<CartBloc>(context).add(
              ChangePaymentModeEvent(selectedModeInt: mode.toInt()),
            );
          },
        ),
        const Divider(),
        OrderDeliveryAddressSelection(
          onAddressSelection: (id) => _addressId = id,
        ),
        SizedBox(height: LayoutConstants.dimen_32.h)
      ];

  List<Widget> _emptyCartIndicatorWidgets() => [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_16.h,
          ),
          child: Text(
            'The cart is empty. '
            'Please add products to cart for getting cart details.',
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: AppColor.black40,
                ),
          ),
        ),
        Container(
          height: LayoutConstants.dimen_48.h,
          margin: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_16.h,
          ),
          child: RaisedButton(
            color: AppColor.primaryColor,
            shape: LayoutConstants.borderlessRoundedRectangle,
            onPressed: () => BlocProvider.of<DashboardBloc>(context).add(
              NavigateToPageEvent(
                pageIndex: DashboardBottomNavigationItem.home.index,
              ),
            ),
            child: Text(
              'Go to Home',
              style: Theme.of(context).textTheme.button.copyWith(
                    color: AppColor.white,
                  ),
            ),
          ),
        ),
      ];

  // =======================================================================

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
                needsCartValidation: true,
                productEntity: cartProduct.product,
              ),
            ),
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
    final coupon =
        await Navigator.pushNamed(context, RouteConstants.applyCouponPromoCode);
    if (coupon != null && coupon is CouponEntity) {
      if (coupon.code?.isNotEmpty == true) {
        appliedCouponPromoCode = coupon.code;
        BlocProvider.of<CartBloc>(context).add(
          ApplyPromoCodeToCartEvent(promoCode: appliedCouponPromoCode),
        );
      }
    }
  }

  void _removeAppliedCouponPromoCode() {
    BlocProvider.of<CartBloc>(context).add(
      RemovePromoCodeFromCartEvent(),
    );
  }

  Widget _cartBottomWidget(CartState state) {
    if (state is CartLoadedState) {
      return _buttonWithContainer();
    }
    return Container();
  }

  Container _buttonWithContainer() => Container(
        height: LayoutConstants.dimen_48.h,
        margin: EdgeInsets.symmetric(
            horizontal: LayoutConstants.dimen_16.w,
            vertical: LayoutConstants.dimen_16.h),
        child: RaisedButton(
          color: AppColor.primaryColor,
          shape: LayoutConstants.borderlessRoundedRectangle,
          onPressed: () {
            if (_addressId == null) {
              AnalyticsUtil.trackEvent(eventName: 'place order click event');
              Injector.resolve<SnackBarBloc>().add(ShowSnackBarEvent(
                type: CustomSnackBarType.error,
                text: 'Please provide the delivery address',
              ));
              return;
            }

            BlocProvider.of<CartBloc>(context).add(
              CreateOrderCartEvent(
                paymentModeInt: _paymentMode.toInt(),
                selectedAddressId: _addressId,
              ),
            );
          },
          child: Text(
            'Place Order',
            style: Theme.of(context).textTheme.button.copyWith(
                  color: AppColor.white,
                ),
          ),
        ),
      );
}
