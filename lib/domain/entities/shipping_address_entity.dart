import 'package:aker_foods_retail/domain/entities/society_entity.dart';

class ShippingAddressEntity {
  ShippingAddressEntity({
    this.id,
    this.label,
    this.societyId,
    this.society,
    this.address1,
    this.address2,
    this.zipCode,
    this.city,
    this.country,
    this.longitude,
    this.latitude,
  });

  int id;
  String label;
  int societyId;
  SocietyEntity society;
  String address1;
  String address2;
  String zipCode;
  String city;
  String country;
  String longitude;
  String latitude;
}
