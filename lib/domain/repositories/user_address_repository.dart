import 'package:aker_foods_retail/domain/entities/society_entity.dart';

// ignore: one_member_abstracts
abstract class UserAddressRepository {
  Future<List<SocietyEntity>> getSocieties();
}
