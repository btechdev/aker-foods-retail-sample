import 'package:aker_foods_retail/data/models/cart_item_detail_model.dart';
import 'package:aker_foods_retail/data/models/shipping_address_model.dart';
import 'package:aker_foods_retail/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    int id,
    String orderId,
    String status,
    int totalItem,
    String createdAt,
    String deliveredAt,
    String totalAmount,
    String totalDiscountedAmount,
    String subTotal,
    String couponAmount,
    int paymentStatus,
    int paymentType,
    String totalRefund,
    String note,
    ShippingAddressModel shippingAddressDetails,
    List<CartItemDetailModel> cartItemDetail,
    String deliveryCharges,
  }) : super(
          id: id,
          orderId: orderId,
          status: status,
          totalItem: totalItem,
          createdAt: createdAt,
          deliveredAt: deliveredAt,
          totalAmount: totalAmount,
          totalDiscountedAmount: totalDiscountedAmount,
          subTotal: subTotal,
          couponAmount: couponAmount,
          paymentStatus: paymentStatus,
          paymentType: paymentType,
          totalRefund: totalRefund,
          note: note,
          shippingAddressDetails: shippingAddressDetails,
          cartItemDetail: cartItemDetail,
          deliveryCharges: deliveryCharges,
        );

  // ignore: prefer_constructors_over_static_methods
  static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        orderId: json['order_id'],
        status: json['status'],
        totalItem: json['total_item'],
        createdAt: json['created_at'],
        deliveredAt: json['delivered_at'],
        totalAmount: json['total_amount'],
        totalDiscountedAmount: json['total_discounted_amount'],
        subTotal: json['sub_total'],
        couponAmount: json['coupon_amount'],
        paymentStatus: json['payment_status'],
        paymentType: json['payment_type'],
        totalRefund: json['total_refund'],
        note: json['note'],
        shippingAddressDetails:
            ShippingAddressModel.fromJson(json['shipping_address_details']),
        cartItemDetail: List<CartItemDetailModel>.from(json['cart_item_detail']
            .map((x) => CartItemDetailModel.fromJson(x))),
        deliveryCharges: json['delivery_charges'],
      );
}
