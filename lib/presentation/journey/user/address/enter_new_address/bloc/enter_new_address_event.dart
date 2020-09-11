

import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';

abstract class UserAddressEvent {}

class CreateNewAddressEvent extends UserAddressEvent {
  final AddressModel addressModel;

  CreateNewAddressEvent({this.addressModel});
}

class SelectSocietyEvent extends UserAddressEvent {
  final SocietyModel selectedSociety;

  SelectSocietyEvent({this.selectedSociety});
}

