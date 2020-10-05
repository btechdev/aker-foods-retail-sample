import 'package:aker_foods_retail/domain/entities/billing_entity.dart';
import 'package:aker_foods_retail/domain/entities/cart_product_entity.dart';

class CartEntity {
  String promoCode;
  int paymentMode;
  String deliveryAddress;
  List<CartProductEntity> products;
  BillingEntity billingEntity;

  CartEntity({
    this.promoCode,
    this.paymentMode,
    this.deliveryAddress,
    this.products,
    this.billingEntity,
  });
}
