import 'package:aker_foods_retail/data/local_data_sources/authentication_local_data_source.dart';
import 'package:aker_foods_retail/data/models/firebase_auth_model.dart';
import 'package:aker_foods_retail/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl({this.authenticationLocalDataSource}) : super();

  @override
  Future<bool> saveUserAuthentication(FirebaseAuthModel user) async {
    final result1 = await authenticationLocalDataSource.setUserUid(user.userId);
    final result2 =
        await authenticationLocalDataSource.setFirebaseIdToken(user.idToken);
    final result3 =
        await authenticationLocalDataSource.setRefreshToken(user.refreshToken);
    return result1 && result2 && result3;
  }

  @override
  Future<String> getUserAuthIdToken() async {
    return authenticationLocalDataSource.getFirebaseIdToken();
  }

  @override
  Future<String> getUserAuthRefreshToken() async {
    return authenticationLocalDataSource.getRefreshToken();
  }
}