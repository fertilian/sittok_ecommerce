import 'package:ecommerce_ui/BuyScreen/BuyPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../mocks/mock_data.dart';
import '../../models/product.dart';
import '../../utils/constants.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  Widget appBar(BuildContext context) {
    return Positioned(
      left: 12,
      top: 52,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              FontAwesomeIcons.chevronLeft,
            ),
          ),
          const Text(
            'Keranjang',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget text(Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          product.priceString,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget amountButton() {
    return Container(
      height: 36,
      width: 76,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kSecondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(
            FontAwesomeIcons.minus,
            size: 16,
            color: kBackgroundColor,
          ),
          Text(
            '1',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
          Icon(
            FontAwesomeIcons.plus,
            size: 16,
            color: kBackgroundColor,
          ),
        ],
      ),
    );
  }

  Widget image(String imagePath) {
    return Positioned(
      left: 16,
      bottom: 2,
      child: Image.asset(
        imagePath,
        height: 92,
      ),
    );
  }

  Widget item(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 108, right: 16),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: kPrimaryColor.withOpacity(0.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                text(product),
                const Spacer(),
                amountButton(),
              ],
            ),
          ),
          image(product.imagePath),
        ],
      ),
    );
  }

  Widget cartItems(List<Product> products) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 256),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 120),
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemCount: products.length,
        itemBuilder: (context, index) => item(context, products[index]),
      ),
    );
  }

  Widget costLine(String title, String text, {double fontSize = 16}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget cost(List<Product> products) {
    final subtotal =
    products.fold<double>(0, (value, product) => value + product.price);
    const shipping = 24.50;

    return Positioned(
      left: 24,
      right: 24,
      bottom: 130,
      child: Column(
        children: [
          costLine('Subtotal', '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 16),
          costLine('Shipping', '\$${shipping.toStringAsFixed(2)}'),
          const Divider(
            height: 48,
            thickness: 1,
            color: kSecondaryColor,
          ),
          costLine(
            'Total',
            '\$${(subtotal + shipping).toStringAsFixed(2)}',
            fontSize: 18,
          ),
        ],
      ),
    );
  }

  Widget checkoutButton(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 36,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: kSecondaryColor,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => BuyPage()),
            );
          },
          child: const Center(
            child: Text(
              'Checkout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kBackgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = MockData.getProducts(ProductType.cart);

    return Scaffold(
      body: Stack(
        children: [
          cartItems(products),
          cost(products),
          checkoutButton(context),
          appBar(context),
        ],
      ),
    );
  }
}
