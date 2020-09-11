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
    LocationModel location,
  }) : super(
          id: id,
          label: label,
          address1: address1,
          address2: address2,
          zipCode: zipCode,
          city: city,
          country: country,
          society: society,
          location: location,
        );

  static List<AddressModel> fromListJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> addressMapList = jsonMap['results'];
    final list = addressMapList
        .map((addressMap) => AddressModel.fromJson(addressMap))
        .toList();
    return list;
  }

  factory AddressModel.fromJson(Map<String, dynamic> jsonMap) => AddressModel(
        id: jsonMap['id'],
        label: jsonMap['label'],
        address1: jsonMap['address1'],
        address2: jsonMap['address2'],
        city: jsonMap['city'],
        country: jsonMap['country'],
        zipCode: jsonMap['zip_code'],
        society: SocietyModel.fromJson(jsonMap),
        location: LocationModel.fromJson(jsonMap),
      );

  static Map<String, dynamic> toJson(AddressModel userAddressModel) => {
        'id': userAddressModel.id,
        'label': userAddressModel.label,
        'address1': userAddressModel.address1,
        'address2': userAddressModel.address2,
        'city': userAddressModel.city,
        'country': userAddressModel.country,
        'zip_code': userAddressModel.zipCode,
        'society_detail': SocietyModel.toJson(userAddressModel.society),
        'location': LocationModel.toJson(userAddressModel.location),
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
