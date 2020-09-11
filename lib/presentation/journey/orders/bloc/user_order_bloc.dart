import 'package:aker_foods_retail/domain/usecases/user_order_use_case.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_event.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderBloc
    extends Bloc<UserOrderEvent, UserOrderState> {
  final UserOrderUseCase userOrderUseCase;

  UserOrderBloc({this.userOrderUseCase}) : super(EmptyState());

  @override
  Stream<UserOrderState> mapEventToState(
      UserOrderEvent event) async* {
    if (event is FetchUserOrders) {
      _handleFetchOrdersEvent(event);
    }
  }

  Stream<UserOrderState> _handleFetchOrdersEvent(
      UserOrderEvent event) async* {
    yield UserOrderFetchingState();
    final orders = await userOrderUseCase.getOrders();
    yield UserOrderFetchSuccessfulState(orders: orders);
  }
}
