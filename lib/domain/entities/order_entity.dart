import 'package:aker_foods_retail/domain/entities/cart_item_detail_entity.dart';
import 'package:aker_foods_retail/domain/entities/shipping_address_entity.dart';

class OrderEntity {

  int id;
  String orderId;
  String status;
  int totalItem;
  String createdAt;
  String deliveredAt;
  String totalAmount;
  String totalDiscountedAmount;
  String subTotal;
  String couponAmount;
  int paymentStatus;
  int paymentType;
  String totalRefund;
  String note;
  ShippingAddressEntity shippingAddressDetails;
  List<CartItemDetailEntity> cartItemDetail;
  String deliveryCharges;

  OrderEntity({
    this.id,
    this.orderId,
    this.status,
    this.totalItem,
    this.createdAt,
    this.deliveredAt,
    this.totalAmount,
    this.totalDiscountedAmount,
    this.subTotal,
    this.couponAmount,
    this.paymentStatus,
    this.paymentType,
    this.totalRefund,
    this.note,
    this.shippingAddressDetails,
    this.cartItemDetail,
    this.deliveryCharges,
  });
}
