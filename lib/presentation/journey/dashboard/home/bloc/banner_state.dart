import 'package:aker_foods_retail/domain/entities/banner_info_entity.dart';

abstract class BannerState {}

class EmptyState extends BannerState {}

class FetchingBannerState extends BannerState {}

class FetchBannerSuccessState extends BannerState {
  final List<BannerInfoEntity> banners;

  FetchBannerSuccessState({this.banners});
}

class FetchBannerFailureState extends BannerState {}