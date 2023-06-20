
enum ProductCategory {  All, Laptop, Ram, Monitor, Keyboard, Charger }

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageName;
  final String width;
  final String height;
  final String weight;
  int _quantity;
  bool isAvailable;
  bool isFavorite;

  int get quantity => _quantity;

  set quantity(int newQuantity){
    if (newQuantity >= 0 ) _quantity = newQuantity;
  }

  String get priceString => '\$${price.toStringAsFixed(2)}';
  String get imagePath => 'assets/images/$imageName.png';

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageName,
    required int quantity,
    required this.width,
    required this.height,
    required this.weight,
    required this.isAvailable,
    this.isFavorite = false,
  }) :_quantity=quantity;
}

