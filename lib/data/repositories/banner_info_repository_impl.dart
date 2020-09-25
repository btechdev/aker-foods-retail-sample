import 'package:aker_foods_retail/data/remote_data_sources/banner_info_remote_data_source.dart';
import 'package:aker_foods_retail/domain/entities/banner_info_entity.dart';
import 'package:aker_foods_retail/domain/repositories/banner_info_repository.dart';

class BannerInfoRepositoryImpl extends BannerInfoRepository {
  final BannerInfoRemoteDataSource bannerInfoRemoteDataSource;

  BannerInfoRepositoryImpl({this.bannerInfoRemoteDataSource});

  @override
  Future<List<BannerInfoEntity>> getBanners() async =>
      bannerInfoRemoteDataSource.getBanners();
}
