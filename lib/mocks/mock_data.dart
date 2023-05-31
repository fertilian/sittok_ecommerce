import '../models/product.dart';

enum ProductType {
  popular,
  newArrivals,
  cart,
}

class MockData {
  static final _products = [
    Product(
      id: 1,
      name: 'Oasis',
      description:
          "The Oasis chair is the perfect spot to kick back and unwind after a "
          "long day. Its supportive backrest cradles your body as you sink into "
          "the chair, providing the ultimate in comfort and support. Whether "
          "you're watching TV, reading a book, or just lounging around, this "
          "chair is the perfect place to relax and let go of all your stress. "
          "So why wait? Get ready to sink into pure bliss with our Oasis chair.",
      price: 54.99,
      imageName: "chair_1",
      width: "53.8 cm",
      height: "76.2 cm",
      weight: "5.8 kg",
    ),
    Product(
      id: 2,
      name: 'Harmony',
      description:
          "Find inner peace in the luxurious Harmony chair. With a spacious "
          "seat cushion and high backrest, this chair is perfect for relaxation. "
          "Made from high-quality materials, including a sturdy wooden frame and "
          "durable upholstery, it can withstand daily use. Use it to read, watch "
          "TV, or just enjoy a moment of solitude.",
      price: 69.99,
      imageName: "chair_2",
      width: "58.4 cm",
      height: "73.7 cm",
      weight: "7.4 kg",
    ),
    Product(
      id: 3,
      name: 'Ivory',
      description:
          "The Ivory chair is a stylish and elegant seat for any dining room. "
          "It is made from high-quality materials, including a sturdy wooden "
          "frame and durable upholstery, and is built to withstand daily use. "
          "Its crisp white color adds a touch of sophistication and a modern "
          "touch to any decor, and its versatility makes it an excellent "
          "addition to any dining room.",
      price: 39.99,
      imageName: "chair_3",
      width: "52.1 cm",
      height: "68.8 cm",
      weight: "2.6 kg",
    ),
    Product(
      id: 4,
      name: 'Eclipse',
      description:
          "Experience the darkness of the night with our luxurious Eclipse "
          "dining room chair. With its black finish and comfortable cushioned "
          "seat, this chair is the perfect addition to any modern dining space. "
          "Whether you're hosting a dinner party or simply enjoying a quiet meal "
          "at home, the Eclipse chair is sure to make a statement.",
      price: 49.99,
      imageName: "chair_4",
      width: "56.7 cm",
      height: "58.3 cm",
      weight: "4.4 kg",
    ),
    Product(
      id: 5,
      name: 'Midnight Sky',
      description:
          "Bring the beauty of the night sky into your living room with our "
          "comfortable and stylish Midnight Sky chair. With its deep black "
          "finish and plush cushioned seats, this chair is perfect for "
          "relaxation. Whether you're curling up with a good book or simply "
          "taking a break from the day's activities, the Midnight Sky is sure to "
          "provide a cozy and inviting space.",
      price: 89.99,
      imageName: "chair_5",
      width: "67.4 cm",
      height: "83.9 cm",
      weight: "14.8 kg",
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
    }
  }

  static Product getProductById(int productId) =>
      _products.firstWhere((product) => product.id == productId);

  static List<Product> getProducts(ProductType productType) {
    final productIds = _getProductIds(productType);
    return productIds.map((id) => getProductById(id)).toList();
  }
}
