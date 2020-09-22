import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'coupons_event.dart';
import 'coupons_state.dart';

class CouponsBloc extends Bloc<CouponsEvent, CouponsState> {
  final CartUseCase cartUseCase;

  CouponsBloc({this.cartUseCase}) : super(CouponsInitialState());

  @override
  Stream<CouponsState> mapEventToState(CouponsEvent event) async* {
    if (event is FetchCouponsEvent) {
      yield* _handleFetchCouponEvent(event);
    }
  }

  Stream<CouponsState> _handleFetchCouponEvent(FetchCouponsEvent event) async* {
    CouponsFetchingState();
    final coupons = await cartUseCase.getCategories();
    yield CouponsFetchSuccessState(coupons: coupons);
  }
}
