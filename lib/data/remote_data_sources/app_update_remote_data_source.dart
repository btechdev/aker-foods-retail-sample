import 'package:aker_foods_retail/data/models/force_update_data_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';

class AppUpdateRemoteDataSource {
  final ApiClient apiClient;

  AppUpdateRemoteDataSource({this.apiClient});

  Future<ForceUpdateDataModel> getForceUpdateData(
      String platform, String appVersion) async {
    final response = await apiClient.get('${ApiEndpoints.appUpdate}'
        '?app_version=$appVersion&app_type=$platform');
    return ForceUpdateDataModel.fromJson(response);
  }
}
