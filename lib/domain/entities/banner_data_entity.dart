class BannerDataEntity {
  int id;
  String name;
  String description;
  String type;
  List<String> ids;
  String imageUrl;

  BannerDataEntity({
    this.id,
    this.name,
    this.description,
    this.type,
    this.ids,
    this.imageUrl,
  });
}
