import 'package:aker_foods_retail/domain/usecases/cart_use_case.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_event.dart';
import 'package:aker_foods_retail/presentation/common_blocs/cart_bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase cartUseCase;

  CartBloc(this.cartUseCase) : super(CartInitialState());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartEvent) {
      yield* _processLoadCartEvent(event);
    } else if (event is AddProductToCartEvent) {
      yield* _processAddProductToCartEvent(event);
    } else if (event is RemoveProductFromCartEvent) {
      yield* _processRemoveProductFromCartEvent(event);
    }
  }

  Stream<CartState> _processLoadCartEvent(LoadCartEvent event) async* {
    final cartEntity = await cartUseCase.getCartData();
    final Map<int, int> idCountMap = Map();
    for (final cartProductEntity in cartEntity.products) {
      idCountMap[cartProductEntity.product.id] = cartProductEntity.count;
    }
    yield CartLoadedState(productIdCountMap: idCountMap);
  }

  Stream<CartState> _processAddProductToCartEvent(
      AddProductToCartEvent event) async* {
    final cartEntity = await cartUseCase.addProduct(event.productEntity);
    final Map<int, int> idCountMap = Map();
    for (final cartProductEntity in cartEntity.products) {
      idCountMap[cartProductEntity.product.id] = cartProductEntity.count;
    }
    yield CartProductUpdatedState(productIdCountMap: idCountMap);
  }

  Stream<CartState> _processRemoveProductFromCartEvent(
      RemoveProductFromCartEvent event) async* {
    final cartEntity = await cartUseCase.removeProduct(event.productEntity);
    final Map<int, int> idCountMap = Map();
    for (final cartProductEntity in cartEntity.products) {
      idCountMap[cartProductEntity.product.id] = cartProductEntity.count;
    }
    yield CartProductUpdatedState(productIdCountMap: idCountMap);
  }
}
