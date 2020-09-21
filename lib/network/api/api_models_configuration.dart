import 'package:aker_foods_retail/data/models/product_category_model.dart';
import 'package:aker_foods_retail/data/models/product_model.dart';
import 'package:aker_foods_retail/data/models/product_subcategory_model.dart';
import 'package:aker_foods_retail/data/models/address_model.dart';
import 'package:aker_foods_retail/data/models/coupon_model.dart';
import 'package:aker_foods_retail/data/models/order_model.dart';
import 'package:aker_foods_retail/data/models/society_model.dart';

import 'api_response_parser.dart';

Future<void> configureApiModels() async {
  ApiResponseParser.addParsingFunction(SocietyModel, SocietyModel.fromJson);
  ApiResponseParser.addParsingFunction(
      ProductCategoryModel, ProductCategoryModel.fromJson);
  ApiResponseParser.addParsingFunction(
      ProductSubcategoryModel, ProductSubcategoryModel.fromJson);
  ApiResponseParser.addParsingFunction(ProductModel, ProductModel.fromJson);
  ApiResponseParser.addParsingFunction(CouponModel, CouponModel.fromJson);
  ApiResponseParser.addParsingFunction(OrderModel, OrderModel.fromJson);
  ApiResponseParser.addParsingFunction(AddressModel, AddressModel.fromJson);
}
