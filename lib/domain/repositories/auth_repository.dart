import 'package:aker_foods_retail/data/models/user_model.dart';

abstract class AuthRepository {
  Future<bool> saveUserAuthentication(UserModel user);

  Future<String> getUserAuthIdToken();

  Future<String> getUserAuthRefreshToken();
}
