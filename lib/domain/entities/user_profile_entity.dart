import 'package:aker_foods_retail/domain/entities/referral_entity.dart';

class UserProfileEntity {
  final String salutation;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String userProfileImageUrl;
  final String referralCode;
  final double currentBalance;
  final ReferralEntity referral;

  UserProfileEntity({
    this.salutation,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.userProfileImageUrl,
    this.referralCode,
    this.currentBalance,
    this.referral,
  });
}
