import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/domain/usecases/user_order_use_case.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_event.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  static const pageSize = 10;

  final UserOrderUseCase userOrderUseCase;

  final List<OrderModel> _orders = [];
  bool _isLastPageFetched = false;
  int _currentPage = 1;
  String _next;

  UserOrderBloc({this.userOrderUseCase}) : super(EmptyState());

  @override
  Stream<UserOrderState> mapEventToState(UserOrderEvent event) async* {
    if (event is FetchUserOrders) {
      yield* _handleFetchOrdersEvent(event);
    }
  }

  Stream<UserOrderState> _handleFetchOrdersEvent(FetchUserOrders event) async* {
    if (_isLastPageFetched) {
      return;
    }

    if (_next == null) {
      yield UserOrderFetchingState();
    }

    try {
      final response = await userOrderUseCase.getOrders(_currentPage, pageSize);
      _orders.addAll(response.data);
      _next = response.next;
      _currentPage++;
      _isLastPageFetched = _next == null;
      yield UserOrderFetchSuccessfulState(orders: _orders);
    } catch (e) {
      yield UserOrderPaginationFailedState(orders: _orders);
    }
  }
}
