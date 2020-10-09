import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

abstract class UserAddressRepository {
  Future<ApiResponse<SocietyEntity>> getSocieties(int pageNo, int pageSize);

  Future<void> createNewAddress(AddressModel addressModel);

  Future<ApiResponse<AddressModel>> getAddresses(int pageNo, int pageSize);

  Future<AddressModel> getSelectedAddress();

  Future<bool> setSelectedAddress(AddressModel addressModel);

  Future<List<int>> getServiceablePinCodes();
}
