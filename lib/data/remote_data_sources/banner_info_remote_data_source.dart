import 'package:aker_foods_retail/data/models/banner_info_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';

class BannerInfoRemoteDataSource {
  final ApiClient apiClient;

  BannerInfoRemoteDataSource({this.apiClient});

  Future<List<BannerInfoModel>> getBanners() async {
    final response = await apiClient.get(ApiEndpoints.dashboard);
    return BannerInfoModel.fromListJson(response);
  }
}
