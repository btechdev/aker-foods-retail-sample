import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/domain/repositories/user_profile_repository.dart';

class UserProfileUseCase {
  final UserProfileRepository userProfileRepository;

  UserProfileUseCase({this.userProfileRepository});

  Future<void> setupUserProfile(UserProfileModel user) async =>
      userProfileRepository.setupUserProfile(user);

  Future<UserProfileModel> fetchUserProfile() async =>
      userProfileRepository.fetchUserProfile();

  Future<void> updateUserProfile(UserProfileModel user) async =>
      userProfileRepository.updateUserProfile(user);

  Future<bool> clearLocalPreferences() async =>
      userProfileRepository.clearLocalPreferences();
}
