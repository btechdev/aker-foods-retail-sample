import 'dart:async';

import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/data/models/razorpay_payment_model.dart';
import 'package:aker_foods_retail/domain/entities/order_payment_reinitiate_response_entity.dart';
import 'package:aker_foods_retail/domain/usecases/user_order_use_case.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/loader_bloc/loader_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_bloc.dart';
import 'package:aker_foods_retail/presentation/common_blocs/snack_bar_bloc/snack_bar_event.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_event.dart';
import 'package:aker_foods_retail/presentation/journey/orders/bloc/user_order_state.dart';
import 'package:aker_foods_retail/presentation/widgets/custom_snack_bar/snack_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class UserOrderBloc extends Bloc<UserOrderEvent, UserOrderState> {
  static const pageSize = 10;
  final SnackBarBloc snackBarBloc;
  final UserOrderUseCase userOrderUseCase;
  final LoaderBloc loaderBloc;

  final List<OrderModel> _orders = [];
  bool _isLastPageFetched = false;
  int _currentPage = 1;
  String _next;

  int _cartId;
  Timer _orderPaymentVerificationPollingTimer;
  static const int _orderPaymentVerificationPollingInterval = 10;
  int _verifyOrderPaymentPollingRemainingSeconds = 10 * 30; // 300 seconds

  UserOrderBloc({this.snackBarBloc, this.userOrderUseCase, this.loaderBloc})
      : super(EmptyState());

  @override
  Stream<UserOrderState> mapEventToState(UserOrderEvent event) async* {
    if (event is FetchUserOrders) {
      yield* _handleFetchOrdersEvent(event);
    } else if (event is ReinitiatePaymentForOrderEvent) {
      yield* _handleReinitiatePaymentForOrderEvent(event);
    } else if (event is VerifyOrderTransactionEvent) {
      yield* _handleVerifyOrderTransactionEvent(event);
    } else if (event is OrderPaymentSuccessEvent) {
      yield* _processOrderPaymentSuccessEvent(event);
    } else if (event is OrderPaymentFailedEvent) {
      yield* _processOrderPaymentFailedEvent(event);
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

  Stream<UserOrderState> _handleVerifyOrderTransactionEvent(
      VerifyOrderTransactionEvent event) async* {
    _startTimer();
  }

  Stream<UserOrderState> _processOrderPaymentSuccessEvent(
      OrderPaymentSuccessEvent event) async* {
    yield NavigateToOrderListPageState();
  }

  Stream<UserOrderState> _processOrderPaymentFailedEvent(
      OrderPaymentFailedEvent event) async* {
    yield NavigateToOrderListPageState();
  }

  Future<void> _timerCallback() async {
    try {
      final paymentIsVerified =
          await userOrderUseCase.verifyTransactionForOrder(_cartId);
      if (paymentIsVerified) {
        _orderPaymentVerificationPollingTimer.cancel();
        loaderBloc.add(DismissLoaderEvent());
        add(OrderPaymentSuccessEvent());
        snackBarBloc.add(ShowSnackBarEvent(
          type: CustomSnackBarType.success,
          text: 'Payment successful : $_cartId',
        ));
        return;
      }
    } catch (_) {}
    _verifyOrderPaymentPollingRemainingSeconds -= 10;
    if (_verifyOrderPaymentPollingRemainingSeconds > 0) {
      _startTimer();
    } else {
      _orderPaymentVerificationPollingTimer.cancel();
      loaderBloc.add(DismissLoaderEvent());
      add(OrderPaymentFailedEvent());
      snackBarBloc.add(
        ShowSnackBarEvent(
          type: CustomSnackBarType.error,
          text: 'Failed to verify the order payment.',
        ),
      );
    }
  }

  void _startTimer() {
    /// NOTE: Run timer for max 300 seconds
    _orderPaymentVerificationPollingTimer = Timer(
      const Duration(seconds: _orderPaymentVerificationPollingInterval),
      _timerCallback,
    );
  }

  Stream<UserOrderState> _handleReinitiatePaymentForOrderEvent(
      ReinitiatePaymentForOrderEvent event) async* {
//    yield ReinitiatingPaymentForOrderState();
    debugPrint('$loaderBloc');
    loaderBloc.add(ShowLoaderEvent());
    try {
      final response =
          await userOrderUseCase.reinitiatePaymentForOrder('${event.cartId}');
      _cartId = event.cartId;
      _initiateRazorPayTransaction(response);
//      yield ReinitiatePaymentForOrderSuccessfulState(order: response);
    } catch (e) {
      loaderBloc.add(DismissLoaderEvent());
      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: 'Unable to reinitiate payment for this order',
      ));
      yield ReinitiatePaymentForOrderFailedState();
    }
  }

  void _initiateRazorPayTransaction(
      OrderPaymentReinitiateResponseEntity orderDetails) {
    final razorpayPaymentModel = RazorpayPaymentModel(
        orderId: orderDetails.orderId,
        amount: orderDetails.amount,
        name: orderDetails.title,
        description: orderDetails.description);
    try {
      Razorpay()
        ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
        ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
        ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet)
        ..open(razorpayPaymentModel.toJson());
    } catch (e) {
      debugPrint(e.toString());
      snackBarBloc.add(ShowSnackBarEvent(
        type: CustomSnackBarType.error,
        text: 'Payment error: ${e.message}',
      ));
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    add(VerifyOrderTransactionEvent(orderId: response.orderId));
//    snackBarBloc.add(ShowSnackBarEvent(
//      type: CustomSnackBarType.success,
//      text: 'Payment success: ${response.orderId}',
//    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    loaderBloc.add(DismissLoaderEvent());
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: 'Payment error: ${response.message}',
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('success');
    snackBarBloc.add(ShowSnackBarEvent(
      type: CustomSnackBarType.error,
      text: 'Balance added to wallet: ${response.walletName}',
    ));
  }
}
