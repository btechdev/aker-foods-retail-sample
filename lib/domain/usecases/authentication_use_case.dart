import 'package:aker_foods_retail/data/models/firebase_auth_model.dart';
import 'package:aker_foods_retail/domain/entities/firebase_auth_entity.dart';
import 'package:aker_foods_retail/domain/repositories/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AuthenticationUseCase {
  final AuthenticationRepository authenticationRepository;

  AuthenticationUseCase({
    @required this.authenticationRepository,
  });

  Future<bool> saveUserAuthentication(FirebaseAuthEntity user) =>
      authenticationRepository
          .saveUserAuthentication(FirebaseAuthModel.fromEntity(user));

  Future<bool> updateFirebaseIdToken(String idToken) =>
      authenticationRepository.updateFirebaseIdToken(idToken);

  Future<String> getUserAuthIdToken() =>
      authenticationRepository.getUserAuthIdToken();

  Future<bool> getNewUserFlag() => authenticationRepository.getNewUserFlag();
}
