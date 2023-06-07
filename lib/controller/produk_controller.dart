import 'package:get/get.dart';
import 'package:ecommerce_ui/models/product.dart';
import 'package:ecommerce_ui/mocks/mock_data.dart';

class ProductController extends GetxController {
  final _products = <Product>[].obs;
  final RxList<Product> favoriteProducts = <Product>[].obs;

  List<Product> get products => _products;

  @override
  void onInit() {
    _fetchProducts();
    super.onInit();
  }

  void _fetchProducts() {
    _products.assignAll(MockData.getProducts(ProductType.favorite));
  }

  bool isFavorite(Product product) {
    return product.isFavorite;
  }
  void addToFavorites(Product product) {
    favoriteProducts.add(product);
  }

  void removeFromFavorites(Product product) {
    favoriteProducts.remove(product);
  }
}
