import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';
import 'package:flutter/foundation.dart';

abstract class BannerState {}

class EmptyState extends BannerState {}

class FetchingBannersState extends BannerState {}

class FetchBannersSuccessState extends BannerState {
  final List<BannerDataEntity> banners;

  FetchBannersSuccessState({this.banners});
}

class FetchBannersFailureState extends BannerState {}

class FetchingBannerDetailsState extends BannerState {}

class FetchBannerDetailsFailedState extends BannerState {
  final List<int> productIds;

  FetchBannerDetailsFailedState({
    @required this.productIds,
  });
}

class FetchBannerCategoryProductsSuccessState extends BannerState {
  final List<ProductCategoryEntity> categories;
  final Map<int, List<ProductEntity>> categoryProductsMap;

  FetchBannerCategoryProductsSuccessState({
    this.categories,
    this.categoryProductsMap,
  });
}

class FetchBannerSubcategoryProductsSuccessState extends BannerState {
  final List<ProductSubcategoryEntity> subcategories;
  final Map<int, List<ProductEntity>> subcategoryProductsMap;

  FetchBannerSubcategoryProductsSuccessState({
    this.subcategories,
    this.subcategoryProductsMap,
  });
}

class FetchBannerProductsSuccessState extends BannerState {
  final List<ProductEntity> products;

  FetchBannerProductsSuccessState({
    @required this.products,
  });
}
