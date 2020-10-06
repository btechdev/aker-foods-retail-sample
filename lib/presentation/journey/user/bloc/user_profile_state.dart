import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/domain/entities/address_entity.dart';
import 'package:meta/meta.dart';

abstract class UserProfileState {}

class EmptyState extends UserProfileState {}

class UserProfileSettingUpState extends UserProfileState {}

class UserProfileSetupSuccessState extends UserProfileState {}

class UserProfileSetupFailedState extends UserProfileState {
  final String errorMessage;

  UserProfileSetupFailedState({@required this.errorMessage});
}

class UserProfileUpdatingState extends UserProfileState {}

class UserProfileUpdateSuccessState extends UserProfileState {}

class UserProfileUpdateFailedState extends UserProfileState {
  final String errorMessage;

  UserProfileUpdateFailedState({@required this.errorMessage});
}

class UserProfileFetchingState extends UserProfileState {}

class UserProfileFetchSuccessState extends UserProfileState {
  final UserProfileModel user;
  final AddressEntity address;

  UserProfileFetchSuccessState({this.user, this.address});
}

class UserProfileFetchFailedState extends UserProfileState {
  final String errorMessage;

  UserProfileFetchFailedState({@required this.errorMessage});
}

class UserLoggingOutState extends UserProfileState {}

class UserLoggedOutState extends UserProfileState {}

class UserAddressFetchSuccessState extends UserProfileState {
  final AddressEntity address;

  UserAddressFetchSuccessState({this.address});
}

class UserAddressFetchFailedState extends UserProfileState {}
