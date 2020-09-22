import 'package:aker_foods_retail/common/utils/database_utils.dart';
import 'package:aker_foods_retail/data/database/hive_data_source.dart';
import 'package:aker_foods_retail/data/database/hive_table_constants.dart';
import 'package:aker_foods_retail/data/database/tables/cart_product_table.dart';
import 'package:aker_foods_retail/data/database/tables/cart_table.dart';
import 'package:aker_foods_retail/data/database/tables/product_table.dart';
import 'package:aker_foods_retail/data/models/cart_model.dart';

class CartLocalDataSource extends HiveDataSource<CartTable, CartModel> {
  CartLocalDataSource() : super(boxName: HiveBoxNameConstants.cart) {
    DatabaseUtil.registerAdapter(ProductTableAdapter());
    DatabaseUtil.registerAdapter(CartProductTableAdapter());
    DatabaseUtil.registerAdapter(CartTableAdapter());
  }

  @override
  Future<CartModel> getModelTypeData() async {
    CartTable cartTable = await get('cart');
    if (cartTable == null) {
      cartTable = CartTable();
      await put('cart', cartTable);
    }
    return cartTable.toModel();
  }

  @override
  Future<void> insertOrUpdateData(CartModel model) async {
    await put('cart', CartTable.fromModel(model));
  }

  @override
  Future<List<CartModel>> getModelTypeList() {
    throw UnimplementedError();
  }

  @override
  Future<void> insertOrUpdateList(List<CartModel> models) {
    throw UnimplementedError();
  }
}
