import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/domain/repositories/cart_repository.dart';

class CartUseCase {
  final CartRepository cartRepository;

  CartUseCase(this.cartRepository);

  Future<List<CouponModel>> getCategories() async =>
      cartRepository.getPromoCodes();
}
