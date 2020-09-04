import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/domain/repositories/user_profile_repository.dart';

class UserProfileUseCase {
  final UserProfileRepository userProfileRepository;

  UserProfileUseCase({this.userProfileRepository});

  Future<void> setupUserProfile(UserProfileModel user) =>
      userProfileRepository.setupUserProfile(user);

  Future<UserProfileModel> fetchUserProfile() =>
      userProfileRepository.fetchUserProfile();

  Future<void> updateUserProfile(UserProfileModel user) =>
      userProfileRepository.updateUserProfile(user);
}
