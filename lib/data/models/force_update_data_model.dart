import 'package:aker_foods_retail/domain/entities/force_update_data_entity.dart';

class ForceUpdateDataModel extends ForceUpdateDataEntity {
  ForceUpdateDataModel({
    bool isMandatory,
    String appUrl,
    String version,
    String releasedDate,
  }) : super(
          isMandatory: isMandatory,
          appUrl: appUrl,
          version: version,
          releasedDate: releasedDate,
        );

  factory ForceUpdateDataModel.fromJson(Map<String, dynamic> json) =>
      ForceUpdateDataModel(
        isMandatory: json['mandatory'],
        appUrl: json['apk_url'],
        version: json['version_name'],
        releasedDate: json['released_on'],
      );

  Map<String, dynamic> toJson() => {
        'mandatory': isMandatory,
        'apk_url': appUrl,
        'version_name': version,
        'released_on': releasedDate,
      };
}
