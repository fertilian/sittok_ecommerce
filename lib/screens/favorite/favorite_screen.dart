import 'package:ecommerce_ui/models/product_size_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_ui/controller/produk_controller.dart';
import 'package:ecommerce_ui/mocks/mock_data.dart'; // Import the MockData class
import 'package:ecommerce_ui/models/product.dart';
class FavoriteScreen extends StatelessWidget {

  final List<Product> favorites;
  const FavoriteScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: MockData.favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = MockData.favoriteProducts[index];
          return ListTile(
            title: Text(product.name),
            // Other product details...
          );
        },
      ),
    );
  }
}
