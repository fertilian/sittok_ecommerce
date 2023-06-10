import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:get/get.dart';
import '../models/product.dart';
import 'package:ecommerce_ui/mocks/mock_data.dart';

class FavoriteController extends GetxController {
  final List<Product> _products = [];

  List<Product> get filteredProducts {
    return _products.where((product) => product.isFavorite).toList();
  }

  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    update();
  }

  @override
  void onInit() {
    _products.addAll(MockData.getProducts(ProductType.popular));
    _products.addAll(MockData.getProducts(ProductType.newArrivals));
    _products.addAll(MockData.getProducts(ProductType.cart));
    super.onInit();
  }
}
