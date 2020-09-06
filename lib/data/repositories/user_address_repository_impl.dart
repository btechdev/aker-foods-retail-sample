import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/data/models/user_address_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_address_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/user_address_repository.dart';

class UserAddressRepositoryImpl implements UserAddressRepository {
  final UserAddressRemoteDataSource userAddressRemoteDataSource;

  UserAddressRepositoryImpl({this.userAddressRemoteDataSource});

  @override
  Future<List<SocietyModel>> getSocieties() async =>
      userAddressRemoteDataSource.getSocieties();

  @override
  Future<void> createNewAddress(UserAddressModel addressModel) async =>
      userAddressRemoteDataSource.createNewAddress(addressModel);
}
