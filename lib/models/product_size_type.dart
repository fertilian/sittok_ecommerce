import 'package:ecommerce_ui/models/categorical.dart';
import 'package:ecommerce_ui/models/numerical.dart';

class ProductSizeType {
  List<Numerical>? numerical;
  List<Categorical>? categorical;

  ProductSizeType({this.numerical, this.categorical});
}
