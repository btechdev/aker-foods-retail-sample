import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserAddressUseCase {
  final UserAddressRepository userAddressRepository;

  UserAddressUseCase({this.userAddressRepository});

  Future<ApiResponse<SocietyEntity>> getSocieties(
          int pageNo, int pageSize) async =>
      userAddressRepository.getSocieties(pageNo, pageSize);

  Future<void> createNewAddress(AddressModel address) async =>
      userAddressRepository.createNewAddress(address);

  Future<ApiResponse<AddressModel>> getAddresses(
          int pageNo, int pageSize) async =>
      userAddressRepository.getAddresses(pageNo, pageSize);

  Future<AddressModel> getSelectedAddress() async =>
      userAddressRepository.getSelectedAddress();

  Future<bool> setSelectedAddress(AddressModel addressModel) async =>
      userAddressRepository.setSelectedAddress(addressModel);

  Future<List<int>> getServiceablePinCodes() async =>
      userAddressRepository.getServiceablePinCodes();
}
