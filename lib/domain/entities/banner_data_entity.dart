class BannerDataEntity {
  String imageUrl;
  BannerActionEntity action;

  BannerDataEntity({
    this.imageUrl,
    this.action,
  });
}

class BannerActionEntity {
  String type;
  List<int> ids;

  BannerActionEntity({
    this.type,
    this.ids,
  });
}
