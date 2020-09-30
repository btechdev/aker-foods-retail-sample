import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';

// ignore: one_member_abstracts
abstract class BannerInfoRepository {
  Future<List<BannerDataEntity>> getBanners();
}
