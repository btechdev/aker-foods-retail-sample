import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';
import 'package:aker_foods_retail/network/api/api_endpoints.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';
import 'package:flutter/material.dart';

class UserAddressRemoteDataSource {
  final ApiClient apiClient;

  UserAddressRemoteDataSource({this.apiClient});

  Future<ApiResponse<SocietyModel>> getSocieties(
      int pageNo, int pageSize) async {
    final jsonMap = await apiClient
        .get('${ApiEndpoints.societies}?page=$pageNo&page_size=$pageSize');
    return ApiResponse<SocietyModel>.fromJsonMap(jsonMap);
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

  Future<ApiResponse<AddressModel>> getUserAddresses(
      int pageNo, int pageSize) async {
    final jsonMap = await apiClient
        .get('${ApiEndpoints.newAddress}?page=$pageNo&page_size=$pageSize');
    return ApiResponse<AddressModel>.fromJsonMap(jsonMap);
  }
}
