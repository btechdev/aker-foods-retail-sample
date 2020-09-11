import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';

abstract class UserAddressRepository {
  Future<List<SocietyEntity>> getSocieties();

  Future<void> createNewAddress(AddressModel addressModel);

  Future<List<AddressModel>> getAddresses();

  Future<AddressModel> getSelectedAddress();

  Future<bool> setSelectedAddress(AddressModel addressModel);
}
