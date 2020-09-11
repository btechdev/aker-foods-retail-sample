import 'package:aker_foods_retail/data/models/address_model.dart';

abstract class ChangeAddressEvent {}

class FetchAddressesEvent extends ChangeAddressEvent {}

class SelectCurrentAddressEvent extends ChangeAddressEvent {
  final AddressModel selectedAddress;

  SelectCurrentAddressEvent({this.selectedAddress});
}

class FetchCurrentAddressEvent extends ChangeAddressEvent {}
