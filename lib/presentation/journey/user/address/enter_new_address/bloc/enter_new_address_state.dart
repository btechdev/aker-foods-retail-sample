import 'package:aker_foods_retail/data/models/society_model.dart';
import 'package:meta/meta.dart';


abstract class EnterNewAddressState {}

class EmptyState extends EnterNewAddressState {}

class CreatingNewAddressState extends EnterNewAddressState {}

class CreateNewAddressSuccessState extends EnterNewAddressState {}

class CreateNewAddressFailedState extends EnterNewAddressState {
  final String errorMessage;

  CreateNewAddressFailedState({@required this.errorMessage});
}

class SocietySelectedState extends EnterNewAddressState {
  final SocietyModel societyModel;
  SocietySelectedState({@required this.societyModel});
}