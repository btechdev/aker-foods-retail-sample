import 'package:aker_foods_retail/data/models/user_profile_model.dart';

abstract class UserProfileEvent {}

class FetchUserProfileEvent extends UserProfileEvent {}

class UpdateUserProfileEvent extends UserProfileEvent {
  final UserProfileModel user;

  UpdateUserProfileEvent({this.user});
}

class SetupUserProfileEvent extends UserProfileEvent {
  final UserProfileModel user;
  final String referralCode;

  SetupUserProfileEvent({this.user, this.referralCode});
}
