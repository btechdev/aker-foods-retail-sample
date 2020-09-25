import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    int id,
    String label,
    String address1,
    String address2,
    String zipCode,
    String city,
    String country,
    SocietyModel society,
    double latitude,
    double longitude,
  }) : super(
          id: id,
          label: label,
          address1: address1,
          address2: address2,
          zipCode: zipCode,
          city: city,
          country: country,
          society: society,
          latitude: latitude,
          longitude: longitude,
        );

//  // ignore: prefer_constructors_over_static_methods
//  static AddressModel fromJson(Map<String, dynamic> jsonMap) => AddressModel(
//        id: jsonMap['id'],
//        label: jsonMap['label'],
//        address1: jsonMap['address1'],
//        address2: jsonMap['address2'],
//        city: jsonMap['city'],
//        country: jsonMap['country'],
//        zipCode: jsonMap['zip_code'],
//        society: SocietyModel.fromJson(jsonMap['society_detail']),
//        latitude: jsonMap['latitude'],
//        longitude: jsonMap['longitude'],
//      );

  // ignore: prefer_constructors_over_static_methods
  static AddressModel fromJson(Map<String, dynamic> jsonMap) {
    final societyMap = jsonMap.containsKey('society_detail')
        ? jsonMap['society_detail']
        : jsonMap['society'];

    return AddressModel(
      id: jsonMap['id'],
      label: jsonMap['label'],
      address1: jsonMap['address1'],
      address2: jsonMap['address2'],
      city: jsonMap['city'],
      country: jsonMap['country'],
      zipCode: jsonMap['zip_code'],
      society: SocietyModel.fromJson(societyMap),
      latitude: jsonMap['latitude'],
      longitude: jsonMap['longitude'],
    );
  }

  static Map<String, dynamic> toJson(AddressModel userAddressModel) => {
        'id': userAddressModel.id,
        'label': userAddressModel.label,
        'address1': userAddressModel.address1,
        'address2': userAddressModel.address2,
        'city': userAddressModel.city,
        'country': userAddressModel.country,
        'zip_code': userAddressModel.zipCode,
        'society': SocietyModel.toJson(userAddressModel.society),
        'latitude': userAddressModel.latitude,
        'longitude': userAddressModel.longitude,
      };
}

class LocationModel extends LocationEntity {
  LocationModel({
    double latitude,
    double longitude,
  }) : super(
          latitude: latitude,
          longitude: longitude,
        );

  factory LocationModel.fromJson(Map<String, dynamic> jsonMap) =>
      LocationModel(latitude: jsonMap['lat'], longitude: jsonMap['long']);

  static Map<String, dynamic> toJson(LocationModel locationModel) => {
        'lat': locationModel.latitude,
        'long': locationModel.longitude,
      };
}
