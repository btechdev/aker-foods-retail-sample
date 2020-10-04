import 'package:aker_foods_retail/data/models/banner_data_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class BannerInfoRemoteDataSource {
  final ApiClient apiClient;

  BannerInfoRemoteDataSource({this.apiClient});

  Future<List<BannerDataModel>> getBanners() async {
    final jsonMap = await apiClient.get(ApiEndpoints.banners);
    return ApiResponse<BannerDataModel>.fromJsonMap(jsonMap).data;
  }
}
