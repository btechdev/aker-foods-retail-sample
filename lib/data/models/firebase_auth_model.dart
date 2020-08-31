import 'package:aker_foods_retail/domain/entities/firebase_auth_entity.dart';

class FirebaseAuthModel extends FirebaseAuthEntity {
  FirebaseAuthModel({
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

  factory FirebaseAuthModel.fromEntity(FirebaseAuthEntity entity) =>
      FirebaseAuthModel(
        userId: entity.userId,
        idToken: entity.idToken,
        refreshToken: entity.refreshToken,
        displayName: entity.displayName,
        phoneNumber: entity.phoneNumber,
      );
}
