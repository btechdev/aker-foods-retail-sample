import 'package:aker_foods_retail/data/local_data_source/authentication_local_data_source.dart';
import 'package:aker_foods_retail/data/models/user_model.dart';
import 'package:aker_foods_retail/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthRepositoryImpl({this.authenticationLocalDataSource}) : super();

  @override
  Future<bool> saveUserAuthentication(UserModel user) async {
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
