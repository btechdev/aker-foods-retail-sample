import 'package:aker_foods_retail/domain/entities/banner_actions_entity.dart';
import 'package:aker_foods_retail/domain/entities/banner_info_entity.dart';

class BannerInfoModel extends BannerInfoEntity {
  BannerInfoModel({
    String imageUrl,
    BannerActionModel action,
  }) : super(
          imageUrl: imageUrl,
          action: action,
        );

  static List<BannerInfoModel> fromListJson(Map<String, dynamic> jsonMap) {
    final List<dynamic> bannerList = jsonMap['banners'];
    final list = bannerList
        .map((bannerMap) => BannerInfoModel.fromJson(bannerMap))
        .toList();
    return list;
  }

  factory BannerInfoModel.fromJson(Map<String, dynamic> json) =>
      BannerInfoModel(
          imageUrl: json['url'], action: BannerActionModel.fromJson(json));
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
      BannerActionModel(type: json['id'], ids: json['ids']);
}
