import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../mocks/mock_data.dart';
import '../../utils/constants.dart';
import '../checkout_screen/checkout_screen.dart';
import 'components/categories.dart';
import 'components/products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 52, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.barsStaggered,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.solidBell,
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CheckoutScreen(),
                ),
              );
            },
            icon: const Icon(
              FontAwesomeIcons.cartShopping,
            ),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return const Padding(
      padding: EdgeInsets.only(left: 24, right: 100),
      child: Text(
        'Selamat Datang di Sittok',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 48,
        child: TextField(
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: kSecondaryColor,
              ),
            ),
            fillColor: Colors.white,
            hintText: 'Cari Produk Yang Anda Inginkan',
            prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          appBar(context),
          Padding(
            padding: const EdgeInsets.only(top: 84),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white,
                    Colors.white,
                  ],
                  stops: [0.0, 0.05, 1.0],
                ).createShader(bounds);
              },
              child: ListView(
                padding: const EdgeInsets.only(top: 24),
                children: [
                  title(),
                  const SizedBox(height: 24),
                  searchBar(),
                  const SizedBox(height: 24),
                  const Categories(),
                  const SizedBox(height: 24),
                  const Products(
                    title: 'Populer',
                    productType: ProductType.popular,
                  ),
                  const SizedBox(height: 24),
                  const Products(
                    title: 'Produk Baru',
                    productType: ProductType.newArrivals,
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
