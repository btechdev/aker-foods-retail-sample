import 'package:aker_foods_retail/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    String userId,
    String idToken,
    String refreshToken,
    String displayName,
    String phoneNumber,
  }) : super(
          userId: userId,
          idToken: idToken,
          refreshToken: refreshToken,
          displayName: displayName,
          phoneNumber: phoneNumber,
        );

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        userId: entity.userId,
        idToken: entity.idToken,
        refreshToken: entity.refreshToken,
        displayName: entity.displayName,
        phoneNumber: entity.phoneNumber,
      );
}
