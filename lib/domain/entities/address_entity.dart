import 'package:aker_foods_retail/domain/entities/society_entity.dart';

class AddressEntity {
  int id;
  final String label;
  final String address1;
  final String address2;
  final String zipCode;
  final String city;
  final String country;
  final SocietyEntity society;
  final double latitude;
  final double longitude;

  AddressEntity({
    this.id,
    this.label,
    this.address1,
    this.address2,
    this.zipCode,
    this.city,
    this.country,
    this.society,
    this.latitude,
    this.longitude,
  });
}

class LocationEntity {
  final double latitude;
  final double longitude;

  LocationEntity({this.latitude, this.longitude});
}
