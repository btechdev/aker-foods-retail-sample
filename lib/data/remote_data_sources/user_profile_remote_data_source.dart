import 'package:aker_foods_retail/data/models/user_profile_model.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';

class UserProfileRemoteDataSource {
  final ApiClient apiClient;

  UserProfileRemoteDataSource({this.apiClient});

  Future<void> setupUserProfile(
      UserProfileModel user, String referralCode) async {
    // TODO(soham): Implement post call for setting up user profile
  }

  Future<void> updateUserProfile(UserProfileModel user) async {
    // TODO(soham): Implement post call for updating user profile
  }

  Future<UserProfileModel> fetchUserProfile() async {
    // TODO(soham): Fetch current user profile
    return UserProfileModel(
        email: 'abc@gmail.com',
        firstName: 'Sumit',
        lastName: 'Thakre',
        salutation: 'Mr',
        phoneNumber: '+919000900099');
  }
}
