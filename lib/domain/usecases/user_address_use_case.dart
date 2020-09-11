import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';

class UserAddressUseCase {
  final UserAddressRepository userAddressRepository;

  UserAddressUseCase({this.userAddressRepository});

  Future<List<SocietyEntity>> getSocieties() async =>
      userAddressRepository.getSocieties();

  Future<void> createNewAddress(AddressModel address) async =>
      userAddressRepository.createNewAddress(address);

  Future<List<AddressModel>> getAddresses() async =>
      userAddressRepository.getAddresses();

  Future<AddressModel> getSelectedAddress() async =>
      userAddressRepository.getSelectedAddress();

  Future<bool> setSelectedAddress(AddressModel addressModel) async =>
      userAddressRepository.setSelectedAddress(addressModel);
}
