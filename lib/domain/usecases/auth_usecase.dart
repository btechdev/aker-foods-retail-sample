import 'package:aker_foods_retail/data/models/user_model.dart';
import 'package:aker_foods_retail/domain/entities/user_entity.dart';
import 'package:aker_foods_retail/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({
    @required this.authRepository,
  });

  Future<bool> saveUserAuthentication(UserEntity user) =>
      authRepository.saveUserAuthentication(UserModel.fromEntity(user));

  Future<String> getUserAuthIdToken() => authRepository.getUserAuthIdToken();

  Future<String> getUserAuthRefreshToken() =>
      authRepository.getUserAuthRefreshToken();
}
