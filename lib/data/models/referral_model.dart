import 'package:aker_foods_retail/domain/entities/referral_entity.dart';

class ReferralModel extends ReferralEntity {
  ReferralModel({
    String code,
    String title,
    String description,
    String imageUrl,
  }) : super(
          code: code,
          title: title,
          description: description,
          imageUrl: imageUrl,
        );

  factory ReferralModel.fromJson(Map<String, dynamic> jsonMap) => ReferralModel(
        code: jsonMap['code'],
        title: jsonMap['title'],
        description: jsonMap['description'],
        imageUrl: jsonMap['image_url'],
      );
}
