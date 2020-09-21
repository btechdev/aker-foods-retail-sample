import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/domain/entities/shipping_address_entity.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    int id,
    String label,
    int societyId,
    SocietyModel society,
    String address1,
    String address2,
    String zipCode,
    String city,
    String country,
    String longitude,
    String latitude,
  }) : super(
          id: id,
          label: label,
          societyId: societyId,
          society: society,
          address1: address1,
          address2: address2,
          zipCode: zipCode,
          city: city,
          country: country,
          longitude: longitude,
          latitude: latitude,
        );

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        id: json['id'],
        label: json['label'],
        societyId: json['society_id'],
        society: SocietyModel.fromJson(json['society_detail']),
        address1: json['address1'],
        address2: json['address2'],
        zipCode: json['zip_code'],
        city: json['city'],
        country: json['country'],
        longitude: json['longitude'],
        latitude: json['latitude'],
      );
}
