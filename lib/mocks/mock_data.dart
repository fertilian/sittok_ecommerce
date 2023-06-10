import 'package:ecommerce_ui/models/model_barang.dart';

import '../models/product.dart';
import 'package:ecommerce_ui/controller/produk_controller.dart';
import 'package:get/get.dart';

enum ProductType {
  popular,
  newArrivals,
  cart,
  favorite,
}

class MockData {
  const MockData._();
  static List<Product> _favoriteProducts = [];

  static List<Product> get favoriteProducts => _favoriteProducts;

  static void addToFavorites(Product product) {
    if (!_favoriteProducts.contains(product)) {
      _favoriteProducts.add(product);
    }
  }

  static void removeFromFavorites(Product product) {
    _favoriteProducts.remove(product);
  }

  static final _products = [
    Product(
      id: 1,
      name: 'Charger Asus',
      description:
          "Adaptor laptop ASUS A456U DC output 19V 3.42A "
          "65Watt DC connector 4.0 * 1.35 mm (sedikit lebih kecil drpd yg standard 5.5*2.5mm) "
          "Kualitas : Original "
          "Garansi : 3 Bulan",
      price: 54.99,
      imageName: "chair_1",
      width: "53.8 cm",
      height: "76.2 cm",
      weight: "5.8 kg",
      isAvailable: true,
      quantity: 0,
    ),
    Product(
      id: 2,
      name: 'Fan CR-1200',
      description:
          "Intel: LGA 775/1150/1151/1155/1156/1200 Untuk platform "
          "AMD: AM4/AM3 +/AM3/AM2 +/AM2/FM2 +/FM2/FM1 "
          "Jenis bantalan: bantalan hidrolik "
          "Kecepatan Kipas: 900-2300RPM (± 10%) "
          "Volume udara: 15-36CFM "
          "Kebisingan: 20-30.5dBA "
          "Tegangan Input: DC 12V "
          "Ukuran: Kipas angin: 92x92x2 5mm/3.62x3.62x0.98' ",
      price: 69.99,
      imageName: "chair_2",
      width: "58.4 cm",
      height: "73.7 cm",
      weight: "7.4 kg",
      isAvailable: true,
      quantity: 0,
    ),
    Product(
      id: 3,
      name: 'Meca 6',
      description:
      "MECA 6 RGB Main Feature "
          "60% Layout Mini Keyboard "
          "Magnetic Frame Cover "
          "RGB LED Light "
          "Outemu Removable Switch "
          "Type-C Detachable "
          "Tricolor Keycaps Combination ",
      price: 39.99,
      imageName: "chair_3",
      width: "52.1 cm",
      height: "68.8 cm",
      weight: "2.6 kg",
      isAvailable: true,
      quantity: 0,
    ),
    Product(
      id: 4,
      name: 'Mon BenQ',
      description:
          "Monitor Design BenQ PD2705U menghadirkan akurasi warna untuk professional desainer. "
          "Teknologi HDR dan fitur KVM (atur dua sistem dengan satu set keyboard/ mouse) "
          "USB-C/ Thunderbolt 3 (satu kabel untuk transmisi video/ audio/ data/ power) "
          "DualView (tampilan desain dalam dua mode berdampingan di satu layar) "
          "dan Hotkey Puck G2 (alat untuk mengakses setting)",
      price: 49.99,
      imageName: "chair_4",
      width: "56.7 cm",
      height: "58.3 cm",
      weight: "4.4 kg",
      isAvailable: true,
      quantity: 0,
    ),
    Product(
      id: 5,
      name: 'RAM HYNIX',
      description:
          "READY STOCK !!"
          "GARANSI TUKAR BARU HYNIX DDR3 8GB PC UNTUK RAM CPU PC LIFETIME WARRANTY "
          "Bergaransi Apabila Barang Rusak bisa langsung Retur ganti dengan yang (Baru)",
      price: 89.99,
      imageName: "chair_5",
      width: "67.4 cm",
      height: "83.9 cm",
      weight: "14.8 kg",
      isAvailable: true,
      quantity: 0,
    ),
  ];

  static final _popular = [1, 2, 3, 4];

  static final _newArrivals = [4, 5, 3];

  static final _cart = [1, 2, 5];

  static List<int> _getProductIds(ProductType productType) {
    switch (productType) {
      case ProductType.popular:
        return _popular;
      case ProductType.newArrivals:
        return _newArrivals;
      case ProductType.cart:
        return _cart;
      case ProductType.favorite:
        return _popular;
    }
  }

  static Product getProductById(int productId) =>
      _products.firstWhere((product) => product.id == productId);

  static List<Product> getProducts(ProductType productType) {
    final productIds = _getProductIds(productType);
    return productIds.map((id) => getProductById(id)).toList();
  }


}
