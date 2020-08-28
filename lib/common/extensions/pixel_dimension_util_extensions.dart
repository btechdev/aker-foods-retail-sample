import 'package:aker_foods_retail/common/utils/pixel_dimension_util.dart';

extension DimensionExtension on num {
  num get w => PixelDimensionUtil().setWidth(this);

  num get h => PixelDimensionUtil().setHeight(this);

  num get sp => PixelDimensionUtil().setSp(this);
}
