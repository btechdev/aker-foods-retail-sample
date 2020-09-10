import 'package:aker_foods_retail/common/constants/assertion_constants.dart';
import 'package:aker_foods_retail/domain/usecases/authentication_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthUtils {
  final AuthenticationUseCase authUseCase;

  FirebaseAuthUtils({@required this.authUseCase})
      : assert(authUseCase != null, AssertionConstants.authUseCaseNotNull);

  Future<String> refreshFirebaseIdTokenAndUpdate() async {
    final String newIdToken =
        await FirebaseAuth.instance.currentUser.getIdToken(true);
    await authUseCase.updateFirebaseIdToken(newIdToken);
    return newIdToken;
  }
}
