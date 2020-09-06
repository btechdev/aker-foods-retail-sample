import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:flutter/foundation.dart';

class UserProfileRemoteDataSource {
  final ApiClient apiClient;

  UserProfileRemoteDataSource({this.apiClient});

  Future<void> setupUserProfile(UserProfileModel user) async {
    final payload = UserProfileModel.toJson(user);
    final Map<String, Object> response =
    await apiClient.post(ApiEndpoints.userProfile, payload);
    debugPrint('Enter New address Response ==>');
    response.forEach((key, value) {
      debugPrint('$key = ${value?.toString()}');
    });
  }

  Future<void> updateUserProfile(UserProfileModel user) async {
    final payload = UserProfileModel.toJson(user);
    final Map<String, Object> response =
    await apiClient.post(ApiEndpoints.userProfile, payload);
    debugPrint('Enter New address Response ==>');
    response.forEach((key, value) {
      debugPrint('$key = ${value?.toString()}');
    });
  }

  Future<UserProfileModel> fetchUserProfile() async {
    final response = await apiClient.get(
        ApiEndpoints.userProfile);

    return UserProfileModel.fromJson(response);

  }
}
