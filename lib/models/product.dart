class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageName;
  final String width;
  final String height;
  final String weight;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageName,
    required this.width,
    required this.height,
    required this.weight,
  });

  String get priceString => '\$${price.toStringAsFixed(2)}';
  String get imagePath => 'assets/images/$imageName.png';
}
