import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';
import 'package:flutter/foundation.dart';

abstract class BannerEvent {}

class FetchBannersEvent extends BannerEvent {}

class FetchBannerProductsEvent extends BannerEvent {
  final BannerDataEntity bannerEntity;

  FetchBannerProductsEvent({
    @required this.bannerEntity,
  });
}
