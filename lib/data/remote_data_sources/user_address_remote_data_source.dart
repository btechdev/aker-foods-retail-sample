import 'package:flutter/material.dart';

import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/data/models/user_address_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';

class UserAddressRemoteDataSource {
  final ApiClient apiClient;

  UserAddressRemoteDataSource({this.apiClient});

  Future<List<SocietyModel>> getSocieties() async {
    final map = apiClient.get(ApiEndpoints.newAddress);
  	return SocietyModel.fromListJson(map);
    // TODO(Bhushan): Remove when API integrated
  }
  
  Future<void> createNewAddress(UserAddressModel address) async {
    final payload = UserAddressModel.toJson(address);
    final Map<String, Object> response =
    apiClient.post(ApiEndpoints.newAddress, payload);
    debugPrint('SetupUserProfile Response ==>');
    response.forEach((key, value) {
      debugPrint('$key = ${value?.toString()}');
    });
  }
}
