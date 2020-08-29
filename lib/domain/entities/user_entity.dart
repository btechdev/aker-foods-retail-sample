class UserEntity {
  final String userId;
  final String idToken;
  final String refreshToken;
  final String displayName;
  final String phoneNumber;

  UserEntity({
    this.userId,
    this.idToken,
    this.refreshToken,
    this.displayName,
    this.phoneNumber,
  });
}
