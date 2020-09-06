import 'package:flutter/material.dart';

import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/data/models/user_address_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';

class UserAddressRemoteDataSource {
  final ApiClient apiClient;

  UserAddressRemoteDataSource({this.apiClient});

  Future<List<SocietyModel>> getSocieties() async {
    final map = await apiClient.get(ApiEndpoints.socities);
    final socities = SocietyModel.fromListJson(map);
    return socities;
  }

  Future<void> createNewAddress(UserAddressModel address) async {
    final payload = UserAddressModel.toJson(address);

    try {
      final Map<String, Object> response =
          await apiClient.post(ApiEndpoints.newAddress, payload);
      debugPrint('SetupUserProfile Response ==>');
      response.forEach((key, value) {
        debugPrint('$key = ${value?.toString()}');
      });
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
