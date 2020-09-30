import 'package:aker_foods_retail/domain/entities/banner_data_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_category_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_entity.dart';
import 'package:aker_foods_retail/domain/entities/product_subcategory_entity.dart';
import 'package:aker_foods_retail/domain/usecases/banner_info_usecase.dart';
import 'package:aker_foods_retail/domain/usecases/products_use_case.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/banner/banner_action_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerInfoUseCase bannerInfoUseCase;
  final ProductsUseCase productsUseCase;

  BannerBloc({
    this.bannerInfoUseCase,
    this.productsUseCase,
  }) : super(EmptyState());

  @override
  Stream<BannerState> mapEventToState(BannerEvent event) async* {
    if (event is FetchBannersEvent) {
      yield* _handleBannerFetchEvent(event);
    } else if (event is FetchBannerProductsEvent) {
      yield* _handleFetchBannerProductsEvent(event);
    }
  }

  Stream<BannerState> _handleBannerFetchEvent(FetchBannersEvent event) async* {
    yield FetchingBannersState();
    final banners = await bannerInfoUseCase.getBanners();
    yield FetchBannersSuccessState(banners: banners);
  }

  Stream<BannerState> _handleFetchBannerProductsEvent(
      FetchBannerProductsEvent event) async* {
    yield FetchingBannerDetailsState();

    final BannerActionEntity bannerAction = event.bannerEntity?.action;
    if (bannerAction?.ids?.isNotEmpty != true) {
      // TODO(Bhushan): Yield some state to indicate empty banner data
      return;
    }

    if (bannerAction?.type == BannerActionConstants.category) {
      yield* _yieldCategoriesAndProducts(bannerAction?.ids);
    } else if (bannerAction?.type == BannerActionConstants.subcategory) {
      yield* _yieldSubcategoriesAndProducts(bannerAction?.ids);
    } else {
      yield* _yieldProducts(bannerAction?.ids);
    }
  }

  Stream<BannerState> _yieldCategoriesAndProducts(List<int> ids) async* {
    final List<ProductCategoryEntity> categories = [];
    final Map<int, List<ProductEntity>> categoryProductsMap = Map();
    for (final id in ids) {
      try {
        final products =
            await productsUseCase.getProductsForCategory(categoryId: id);
        if (products?.isNotEmpty == true) {
          categories.add(products[0].category);
          categoryProductsMap[products[0].categoryId] = products;
        }
      } catch (_) {
        /// NOTE: Do nothing, so this particular iteration gets skipped
      }
    }
    yield FetchBannerCategoryProductsSuccessState(
      categories: categories,
      categoryProductsMap: categoryProductsMap,
    );
  }

  Stream<BannerState> _yieldSubcategoriesAndProducts(List<int> ids) async* {
    final List<ProductSubcategoryEntity> subcategories = [];
    final Map<int, List<ProductEntity>> subcategoryProductsMap = Map();
    for (final id in ids) {
      try {
        final products =
            await productsUseCase.getProductsForSubcategory(subcategoryId: id);
        if (products?.isNotEmpty == true) {
          subcategories.add(products[0].subcategory);
          subcategoryProductsMap[products[0].subcategoryId] = products;
        }
      } catch (_) {
        /// NOTE: Do nothing, so this particular iteration gets skipped
      }
    }
    yield FetchBannerSubcategoryProductsSuccessState(
      subcategories: subcategories,
      subcategoryProductsMap: subcategoryProductsMap,
    );
  }

  Stream<BannerState> _yieldProducts(List<int> ids) async* {
    final List<ProductEntity> products = [];
    for (final id in ids) {
      try {
        final ProductEntity product =
            await productsUseCase.getProductWithId(productId: id);
        products.add(product);
      } catch (_) {
        /// NOTE: Do nothing, so this particular iteration gets skipped
      }
    }
    yield FetchBannerProductsSuccessState(products: products);
  }
}
