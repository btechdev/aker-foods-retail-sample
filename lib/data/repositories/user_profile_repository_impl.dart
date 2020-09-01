import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/data/remote_data_sources/user_profile_remote_data_source.dart';
import 'package:aker_foods_retail/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource userProfileRemoteDataSource;

  UserProfileRepositoryImpl({this.userProfileRemoteDataSource});

  @override
  Future<UserProfileModel> fetchUserProfile() =>
      userProfileRemoteDataSource.fetchUserProfile();

  @override
  Future<void> setupUserProfile(UserProfileModel user, String referralCode) =>
      userProfileRemoteDataSource.setupUserProfile(user, referralCode);

  @override
  Future<void> updateUserProfile(UserProfileModel user) =>
      userProfileRemoteDataSource.updateUserProfile(user);
}
