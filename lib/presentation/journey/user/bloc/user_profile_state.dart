import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:meta/meta.dart';

abstract class UserProfileState {}

class EmptyState extends UserProfileState {}

class SettingUpUserProfileState extends UserProfileState {}

class SetupUserProfileSuccessfulState extends UserProfileState {}

class SetupUserProfileFailedState extends UserProfileState {
  final String errorMessage;

  SetupUserProfileFailedState({@required this.errorMessage});
}

class UpdatingUserProfileState extends UserProfileState {}

class UpdateUserProfileSuccessfulState extends UserProfileState {}

class UpdateUserProfileFailedState extends UserProfileState {
  final String errorMessage;

  UpdateUserProfileFailedState({@required this.errorMessage});
}

class FetchingUserProfileState extends UserProfileState {}

class FetchUserProfileSuccessfulState extends UserProfileState {
  final UserProfileModel user;

  FetchUserProfileSuccessfulState({this.user});
}

class FetchUserProfileFailedState extends UserProfileState {
  final String errorMessage;

  FetchUserProfileFailedState({@required this.errorMessage});
}
