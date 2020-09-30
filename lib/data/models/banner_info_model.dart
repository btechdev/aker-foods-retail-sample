import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';

class BannerDataModel extends BannerDataEntity {
  BannerDataModel({
    String imageUrl,
    BannerActionModel action,
  }) : super(
          imageUrl: imageUrl,
          action: action,
        );

  static List<BannerDataModel> fromListJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> bannerList = jsonMap['banners'];
    final list = bannerList
        .map((bannerMap) => BannerDataModel.fromJson(bannerMap))
        .toList();
    return list;
  }

  factory BannerDataModel.fromJson(Map<String, dynamic> json) =>
      BannerDataModel(
        imageUrl: json['url'],
        action: BannerActionModel.fromJson(json['actions']),
      );
}

class BannerActionModel extends BannerActionEntity {
  BannerActionModel({
    String type,
    List<int> ids,
  }) : super(
          type: type,
          ids: ids,
        );

  factory BannerActionModel.fromJson(Map<String, dynamic> json) =>
      BannerActionModel(
        type: json['type'],
        ids: json['ids'].cast<int>(),
      );
}
