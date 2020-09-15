import 'package:aker_foods_retail/data/models/firebase_auth_model.dart';

abstract class AuthenticationRepository {
  Future<bool> saveUserAuthentication(FirebaseAuthModel user);

  Future<bool> updateFirebaseIdToken(String idToken);

  Future<String> getUserAuthIdToken();

  Future<bool> getNewUserFlag();
}
