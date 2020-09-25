import 'package:aker_foods_retail/data/models/billing_model.dart';
import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/models/create_order_body_model.dart';
import 'package:aker_foods_retail/data/models/create_order_response_model.dart';
import 'package:aker_foods_retail/data/models/pre_checkout_body_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSource({this.apiClient});

  Future<List<CouponModel>> getCoupons() async {
    final jsonMap = await apiClient.get(ApiEndpoints.coupons);
    return ApiResponse.fromJson<CouponModel>(jsonMap).data;
  }

  Future<BillingModel> validateCartPreCheckout(
      PreCheckoutBodyModel model) async {
    final jsonMap =
        await apiClient.post(ApiEndpoints.preCheckout, model.toJson());
    return BillingModel.fromJson(jsonMap);
  }

  Future<CreateOrderResponseModel> createOrder(
      CreateOrderBodyModel model) async {
    final jsonMap =
        await apiClient.post(ApiEndpoints.createOrder, model.toJson());
    return CreateOrderResponseModel.fromJson(jsonMap);
  }
}
