import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';
import 'package:aker_foods_retail/domain/repositories/banner_info_repository.dart';

class BannerInfoUseCase {
  final BannerInfoRepository bannerInfoRepository;

  BannerInfoUseCase({this.bannerInfoRepository});

  Future<List<BannerDataEntity>> getBanners() async =>
      bannerInfoRepository.getBanners();
}
