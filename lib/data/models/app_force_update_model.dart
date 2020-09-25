class AppForceUpdateModel {
  bool isMandatory;
  String appUrl;
  String version;
  String releasedDate;

  AppForceUpdateModel.fromJson(Map<String, dynamic> json)
      : isMandatory = json['mandatory'],
        appUrl = json['apk_url'],
        version = json['version_name'],
        releasedDate = json['released_on'];

  Map<String, dynamic> toJson() => {
        'mandatory': isMandatory,
        'apk_url': appUrl,
        'version_name': version,
        'released_on': releasedDate,
      };
}
