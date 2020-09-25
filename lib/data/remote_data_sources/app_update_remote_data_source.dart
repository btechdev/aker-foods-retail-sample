import 'package:aker_foods_retail/data/models/app_force_update_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';

class AppUpdateRemoteDataSource {
  final ApiClient apiClient;

  AppUpdateRemoteDataSource({this.apiClient});

  Future<AppForceUpdateModel> getAppUpdateInfo(
      String appVersion, String platfform) async {
    final response = await apiClient.get('${ApiEndpoints.appUpdate}'
        '?app_version=$appVersion&app_type=$platfform');
    return AppForceUpdateModel.fromJson(response);
  }
}
