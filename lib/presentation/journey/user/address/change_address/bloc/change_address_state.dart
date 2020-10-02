import 'package:aker_foods_retail/data/models/address_model.dart';

abstract class ChangeAddressState {
  List<AddressModel> addresses;
}

class EmptyState extends ChangeAddressState {}

class FetchingAddressState extends ChangeAddressState {}

class FetchAddressSuccessfulState extends ChangeAddressState {
  @override
  final List<AddressModel> addresses;

  FetchAddressSuccessfulState({this.addresses});
}

class FetchAddressFailedState extends ChangeAddressState {
  final String errorMessage;

  FetchAddressFailedState({this.errorMessage});
}

class FetchAddressPaginationFailedState extends ChangeAddressState {
  @override
  final List<AddressModel> addresses;

  FetchAddressPaginationFailedState({this.addresses});
}

class SelectAddressSuccessState extends ChangeAddressState {}

class SelectAddressFailedState extends ChangeAddressState {}

class FetchSelectedAddressSuccessState extends ChangeAddressState {
  final AddressModel addressModel;

  FetchSelectedAddressSuccessState({this.addressModel});
}

class FetchSelectedAddressFailedState extends ChangeAddressState {}
