/*{
"label": "home1",
"address1": "flat 203",
"address2": "Narhe",
"society": {
"name": "Brahma society"
},
"zip_code": 411010,
"city": "Pune",
"country": "IND",

"location": {
"lat": "34.121",
"long": "321.3213"
}

}*/

import 'package:aker_foods_retail/domain/entities/society_entity.dart';

class AddressEntity {
  final String label;
  final String address1;
  final String address2;
  final double zipCode;
  final String city;
  final String country;
  final SocietyEntity society;
  final LocationEntity location;

  AddressEntity({
    this.label,
    this.address1,
    this.address2,
    this.zipCode,
    this.city,
    this.country,
    this.society,
    this.location
});
}

class LocationEntity {
  final double latitude;
  final double longitude;

  LocationEntity({this.latitude, this.longitude});
}