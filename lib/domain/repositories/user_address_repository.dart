import 'package:aker_foods_retail/data/models/user_address_model.dart';
import 'package:aker_foods_retail/domain/entities/society_entity.dart';

// ignore: one_member_abstracts
abstract class UserAddressRepository {
  Future<List<SocietyEntity>> getSocieties();
  Future<void>createNewAddress(UserAddressModel addressModel);
}
