import 'package:aker_foods_retail/data/local_data_sources/authentication_local_data_source.dart';
import 'package:aker_foods_retail/data/models/firebase_auth_model.dart';
import 'package:aker_foods_retail/domain/repositories/authentication_repository.dart';
import 'package:aker_foods_retail/network/api/api_client.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  final ApiClient apiClient;

  AuthenticationRepositoryImpl({
    this.authenticationLocalDataSource,
    this.apiClient,
  }) : super();

  @override
  Future<bool> saveUserAuthentication(FirebaseAuthModel user) async {
    final result1 = await authenticationLocalDataSource.setUserUid(user.userId);
    final result2 = await authenticationLocalDataSource
        .setUserHasSetupProfileFlag(!user.isNewUser);
    final result3 = await updateFirebaseIdToken(user.idToken);
    return result1 && result2 && result3;
  }

  @override
  Future<bool> updateFirebaseIdToken(String idToken) async {
    final result =
        await authenticationLocalDataSource.setFirebaseIdToken(idToken);
    apiClient.updateAuthorizationHeader(idToken);
    return result;
  }

  @override
  Future<String> getUserAuthIdToken() async {
    return authenticationLocalDataSource.getFirebaseIdToken();
  }

  @override
  Future<bool> getUserHasSetupProfileFlag() async =>
      authenticationLocalDataSource.getUserHasSetupProfileFlag();
}
