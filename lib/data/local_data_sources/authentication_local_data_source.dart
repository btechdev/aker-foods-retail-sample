import 'package:aker_foods_retail/common/local_preferences/local_preferences.dart';
import 'package:meta/meta.dart';

class AuthenticationLocalDataSource {
  final LocalPreferences localPreferences;

  AuthenticationLocalDataSource({
    @required this.localPreferences,
  });

  String getUserUid() => localPreferences.get(
        PreferencesKeys.userUid,
      );

  Future<bool> setUserUid(String userUid) => localPreferences.set(
        PreferencesKeys.userUid,
        userUid,
      );

  Future<bool> removeUserUid() => localPreferences.remove(
        PreferencesKeys.userUid,
      );

  String getFirebaseIdToken() => localPreferences.get(
        PreferencesKeys.firebaseIdToken,
      );

  Future<bool> setFirebaseIdToken(String firebaseIdToken) =>
      localPreferences.set(
        PreferencesKeys.firebaseIdToken,
        firebaseIdToken,
      );

  Future<bool> removeFirebaseIdToken() => localPreferences.remove(
        PreferencesKeys.firebaseIdToken,
      );

  bool getUserHasSetupProfileFlag() => localPreferences.get(
        PreferencesKeys.userHasSetupProfile,
      );

  Future<bool> setUserHasSetupProfileFlag(bool flag) =>
      localPreferences.set(PreferencesKeys.userHasSetupProfile, flag);

  Future<bool> removeUserHasSetupProfileFlag() => localPreferences.remove(
        PreferencesKeys.userHasSetupProfile,
      );
}
