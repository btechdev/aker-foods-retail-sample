import 'package:aker_foods_retail/domain/usecases/banner_info_usecase.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/bloc/banner_event.dart';
import 'package:aker_foods_retail/presentation/journey/dashboard/home/bloc/banner_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerInfoUseCase bannerInfoUseCase;
  BannerBloc({this.bannerInfoUseCase}) : super(EmptyState());

  @override
  Stream<BannerState> mapEventToState(BannerEvent event) async* {
    if (event is FetchBannerEvent) {
      yield* _handleBannerFetchEvent(event);
    }
  }

  Stream<BannerState> _handleBannerFetchEvent(FetchBannerEvent event) async* {
    yield FetchingBannerState();
    final banners = await bannerInfoUseCase.getBanners();
    yield FetchBannerSuccessState(banners: banners);
  }

}