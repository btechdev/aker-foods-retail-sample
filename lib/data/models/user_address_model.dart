import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/domain/entities/user_address_entity.dart';

class UserAddressModel extends UserAddressEntity {
  UserAddressModel(
      {String label,
      String address1,
      String address2,
      double zipCode,
      String city,
      String country,
      SocietyModel society,
      LocationModel location})
      : super(
          label: label,
          address1: address1,
          zipCode: zipCode,
          city: city,
          country: country,
          society: society,
          location: location,
        );

  factory UserAddressModel.fromJson(Map<String, dynamic> jsonMap) =>
      UserAddressModel(
        label: jsonMap['label'],
        address1: jsonMap['address1'],
        address2: jsonMap['address2'],
        city: jsonMap['city'],
        country: jsonMap['country'],
        zipCode: jsonMap['zip_code'],
        society: SocietyModel.fromJson(jsonMap),
        location: LocationModel.fromJson(jsonMap),
      );

  static Map<String, dynamic> toJson(UserAddressModel userAddressModel) => {
        'label': userAddressModel.label,
        'address1': userAddressModel.address1,
        'address2': userAddressModel.address2,
        'city': userAddressModel.city,
        'country': userAddressModel.country,
        'zip_code': userAddressModel.zipCode,
        'society': SocietyModel.toJson(userAddressModel.society),
        'location': LocationModel.toJson(userAddressModel.location),
      };
}


class LocationModel extends LocationEntity {
  LocationModel({double latitude, double longitude})
      : super(latitude: latitude, longitude: longitude);

  factory LocationModel.fromJson(Map<String, dynamic> jsonMap) =>
      LocationModel(latitude: jsonMap['lat'], longitude: jsonMap['long']);

  static Map<String, dynamic> toJson(LocationModel locationModel) => {
        'lat': locationModel.latitude,
        'long': locationModel.longitude,
      };
}
