import 'package:aker_foods_retail/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    String salutation,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String userProfileImageUrl,
    String referralCode,
  }) : super(
          salutation: salutation,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          userProfileImageUrl: userProfileImageUrl,
          referralCode: referralCode,
        );

  factory UserProfileModel.fromJson(Map<String, dynamic> jsonMap) =>
      UserProfileModel(
        salutation: getSalutation(jsonMap['gender']),
        firstName: jsonMap['first_name'],
        lastName: jsonMap['last_name'],
        email: jsonMap['email'],
        referralCode: jsonMap['referal_code'],
      );

  static Map<String, dynamic> toJson(UserProfileModel userProfileModel) => {
        'first_name': userProfileModel.firstName,
        'last_name': userProfileModel.lastName,
        'email': userProfileModel.email,
        'referal_code': userProfileModel.referralCode,
        'gender': getGender(userProfileModel.salutation),
      };

  static String getGender(String salutation) {
    switch (salutation) {
      case 'Mr':
        return 'male';

      case 'Miss':
        return 'female';

      default:
        return 'none';
    }
  }

  static String getSalutation(String salutation) {
    switch (salutation) {
      case 'male':
        return 'Mr';

      case 'female':
        return 'Miss';

      default:
        return 'Undefined';
    }
  }
}
