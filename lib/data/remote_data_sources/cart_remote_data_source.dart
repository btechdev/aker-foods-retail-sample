import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class CartRemoteDataSource {
  final ApiClient apiClient;

  CartRemoteDataSource({this.apiClient});

  Future<List<CouponModel>> getPromoCodes() async {
    final jsonMap = await apiClient.get(ApiEndpoints.coupons);
    return ApiResponse.fromJson<CouponModel>(jsonMap).data;
  }
}
