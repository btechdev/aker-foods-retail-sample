class UserProfileEntity {
  final String salutation;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String userProfileImageUrl;
  final String referralCode;
  final double currentBalance;

  UserProfileEntity({
    this.salutation,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.userProfileImageUrl,
    this.referralCode,
    this.currentBalance
  });
}
