import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:flutter/foundation.dart';

abstract class CartEvent {}

class LoadCartEvent extends CartEvent {}

class ValidateCartEvent extends CartEvent {}

class ClearCartEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final bool needsCartValidation;
  final ProductEntity productEntity;

  AddProductToCartEvent({
    this.needsCartValidation = false,
    this.productEntity,
  });
}

class RemoveProductFromCartEvent extends CartEvent {
  final bool needsCartValidation;
  final ProductEntity productEntity;

  RemoveProductFromCartEvent({
    this.needsCartValidation = false,
    this.productEntity,
  });
}

class ApplyPromoCodeToCartEvent extends CartEvent {
  final String promoCode;
  final double discount;

  ApplyPromoCodeToCartEvent({this.discount, this.promoCode});
}

class RemovePromoCodeFromCartEvent extends CartEvent {}

class ApplyDeliveryAddressToCartEvent extends CartEvent {}

class CreateOrderCartEvent extends CartEvent {
  final int paymentModeInt;
  final int selectedAddressId;

  CreateOrderCartEvent({
    @required this.paymentModeInt,
    @required this.selectedAddressId,
  });
}

class NotifyUserAboutProductEvent extends CartEvent {
  final bool needsCartValidation;
  final ProductEntity productEntity;

  NotifyUserAboutProductEvent({
    this.needsCartValidation = false,
    this.productEntity,
  });
}

class CartOrderVerifyPaymentEvent extends CartEvent {
  final int cartId;

  CartOrderVerifyPaymentEvent({@required this.cartId}) : super();
}

class CartOrderPaymentSuccessEvent extends CartEvent {}

class CartOrderPaymentFailedEvent extends CartEvent {}

class ChangePaymentModeEvent extends CartEvent {
  final int selectedModeInt;

  ChangePaymentModeEvent({this.selectedModeInt});
}
