import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';
import 'package:flutter/material.dart';

class UserAddressRemoteDataSource {
  final ApiClient apiClient;

  UserAddressRemoteDataSource({this.apiClient});

  Future<List<SocietyModel>> getSocieties() async {
    final jsonMap = await apiClient.get(ApiEndpoints.societies);
    return ApiResponse.fromJson<SocietyModel>(jsonMap).data;
  }

  Future<void> createNewAddress(AddressModel address) async {
    final payload = AddressModel.toJson(address);
    debugPrint('$payload');
    try {
      final Map<String, Object> response =
          await apiClient.post(ApiEndpoints.newAddress, payload);
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<AddressModel>> getUserAddresses() async {
    final jsonMap = await apiClient.get(ApiEndpoints.newAddress);
    return ApiResponse.fromJson<AddressModel>(jsonMap).data;
  }
}
