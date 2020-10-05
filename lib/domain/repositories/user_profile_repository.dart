import 'package:aker_foods_retail/data/models/user_profile_model.dart';

abstract class UserProfileRepository {
  Future<void> setupUserProfile(UserProfileModel user);
  Future<void> updateUserProfile(UserProfileModel user);
  Future<UserProfileModel> fetchUserProfile();
  Future<bool> setUserHasSetupProfileFlag(bool flag);
  Future<bool> clearLocalPreferences();
  Future<void> registerUserDevice(String deviceId);
}
