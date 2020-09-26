import 'package:aker_foods_retail/domain/entities/product_entity.dart';

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
  final int paymentType;
  final int addressId;

  CreateOrderCartEvent({this.paymentType, this.addressId});
}
