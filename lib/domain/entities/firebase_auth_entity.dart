class FirebaseAuthEntity {
  final bool isNewUser;
  final String userId;
  final String idToken;
  final String refreshToken;
  final String displayName;
  final String phoneNumber;

  FirebaseAuthEntity({
    this.isNewUser = true,
    this.userId,
    this.idToken,
    this.refreshToken,
    this.displayName,
    this.phoneNumber,
  });
}
