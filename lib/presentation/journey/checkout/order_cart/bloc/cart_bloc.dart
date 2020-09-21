import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/journey/checkout/order_cart/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc({this.cartUseCase}) : super(CartEmptyState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is FetchCouponsEvent) {
      yield* _handleFetchCouponEvent(event);
    }
  }

  Stream<CartState> _handleFetchCouponEvent(FetchCouponsEvent event) async* {
    CouponsFetchingState();
    final coupons = await cartUseCase.getCategories();
    yield CouponsFetchSuccessState(coupons: coupons);
  }
}
