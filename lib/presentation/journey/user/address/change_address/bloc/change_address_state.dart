import 'package:aker_foods_retail/data/models/address_model.dart';

abstract class ChangeAddressState {}

class EmptyState extends ChangeAddressState {}

class FetchingAddressState extends ChangeAddressState {}

class FetchAddressSuccessfulState extends ChangeAddressState {
  final List<AddressModel> addresses;

  FetchAddressSuccessfulState({this.addresses});
}

class FetchAddressFailedState extends ChangeAddressState {
  final String errorMessage;

  FetchAddressFailedState({this.errorMessage});
}

class SelectAddressSuccessState extends ChangeAddressState {}

class SelectAddressFailedState extends ChangeAddressState {}

class FetchSelectedAddressSuccessState extends ChangeAddressState {
  final AddressModel addressModel;

  FetchSelectedAddressSuccessState({this.addressModel});
}

class FetchSelectedAddressFailedState extends ChangeAddressState {}
