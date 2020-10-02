import 'package:aker_foods_retail/data/local_data_sources/user_address_local_data_source.dart';
import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_address_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';
import 'package:aker_foods_retail/network/api/api_response.dart';

class UserAddressRepositoryImpl implements UserAddressRepository {
  final UserAddressRemoteDataSource userAddressRemoteDataSource;
  final UserAddressLocalDataSource userAddressLocalDataSource;

  UserAddressRepositoryImpl(
      {this.userAddressRemoteDataSource, this.userAddressLocalDataSource});

  @override
  Future<ApiResponse<SocietyModel>> getSocieties(
          int pageNo, int pageSize) async =>
      userAddressRemoteDataSource.getSocieties(pageNo, pageSize);

  @override
  Future<void> createNewAddress(AddressModel addressModel) async =>
      userAddressRemoteDataSource.createNewAddress(addressModel);

  @override
  Future<AddressModel> getSelectedAddress() async =>
      userAddressLocalDataSource.getSelectedAddress();

  @override
  Future<bool> setSelectedAddress(AddressModel addressModel) =>
      userAddressLocalDataSource.setSelectedAddress(addressModel);

  @override
  Future<ApiResponse<AddressModel>> getAddresses(
          int pageNo, int pageSize) async =>
      userAddressRemoteDataSource.getUserAddresses(pageNo, pageSize);
}
