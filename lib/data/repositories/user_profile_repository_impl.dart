import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_profile_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource userProfileRemoteDataSource;
  final LocalPreferences localPreferences;

  UserProfileRepositoryImpl({
    this.userProfileRemoteDataSource,
    this.localPreferences,
  });

  @override
  Future<UserProfileModel> fetchUserProfile() async =>
      userProfileRemoteDataSource.fetchUserProfile();

  @override
  Future<void> setupUserProfile(UserProfileModel user) async =>
      userProfileRemoteDataSource.setupUserProfile(user);

  @override
  Future<void> updateUserProfile(UserProfileModel user) async =>
      userProfileRemoteDataSource.updateUserProfile(user);

  @override
  Future<bool> setUserHasSetupProfileFlag(bool flag) async =>
      localPreferences.set(PreferencesKeys.userHasSetupProfile, flag);

  @override
  Future<bool> clearLocalPreferences() => localPreferences.clear();

  @override
  Future<void> registerUserDevice(String deviceId) async =>
      userProfileRemoteDataSource.registerUserDevice(deviceId);
}
