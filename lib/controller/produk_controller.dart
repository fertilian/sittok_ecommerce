import 'package:get/get.dart';
import 'package:ecommerce_ui/models/product.dart';
import 'package:ecommerce_ui/mocks/mock_data.dart';

class ProductController extends GetxController {

  final _products = <Product>[].obs;
  final RxList<Product> favoriteProducts = <Product>[].obs;
  final RxList<Product> cartProducts = <Product>[].obs;
  RxInt totalPrice = 0.obs;

  List<Product> get products => _products;

  @override
  void onInit() {
    _fetchProducts();
    super.onInit();
  }

  void calculateTotalPrice(){
    totalPrice.value=0;
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
  void addToCart(Product product){
    product.quantity++;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts);
    calculateTotalPrice();
  }

  void increaseItemQuantity(Product product){
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(Product product){
    product.quantity--;
    calculateTotalPrice();
    update();
  }


  void removeFromFavorites(Product product) {
    favoriteProducts.remove(product);
  }
}
