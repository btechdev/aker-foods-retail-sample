import 'package:aker_foods_retail/data/models/notification_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class NotificationRemoteDataSource {
  final ApiClient apiClient;

  NotificationRemoteDataSource({this.apiClient});

  Future<List<NotificationModel>> getNotifications() async {
    final jsonMap = await apiClient.get(ApiEndpoints.notifications);
    return ApiResponse.fromJson<NotificationModel>(jsonMap).data;
  }
}
