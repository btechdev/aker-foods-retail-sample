import 'package:aker_foods_retail/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  UserProfileModel({
    String salutation,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String userProfileImageUrl,
  }) : super(
          salutation: salutation,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          userProfileImageUrl: userProfileImageUrl,
        );

  factory UserProfileModel.fromJson(Map<String, dynamic> jsonMap) =>
      UserProfileModel(
        salutation: jsonMap['salutation'],
        firstName: jsonMap['firstName'],
        lastName: jsonMap['lastName'],
        email: jsonMap['email'],
        phoneNumber: jsonMap['phoneNumber'],
        userProfileImageUrl: jsonMap['userProfileImageUrl'],
      );
}
