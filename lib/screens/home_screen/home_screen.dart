import 'package:ecommerce_ui/Akun/Akun_screen.dart';
import 'package:ecommerce_ui/screens/favorite/favorite_screen.dart';
import 'package:ecommerce_ui/navBar/navBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ecommerce_ui/models/product.dart';
import '../../mocks/mock_data.dart';
import '../../navBar/navBar.dart';
import 'package:ecommerce_ui/constants.dart';
import '../checkout_screen/checkout_screen.dart';
import 'components/categories.dart';
import 'components/products.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Product> favorites = [];

  List<Widget> _fragments = [
    const FragmentBeranda(),
    const FragmentProduk(),
    FavoriteScreen(favorites: [],),
    const FragmentAkun(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _fragments[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FavoriteScreen(favorites: favorites),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.purple),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.purple),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.purple),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.purple),
            label: 'Akun',
          ),
        ],
      ),

    );
  }
}

class FragmentBeranda extends StatelessWidget {
  const FragmentBeranda({Key? key}) : super(key: key);

  @override
  Widget appBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 52, 12, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NavBar(),
                ),
              );
            },
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
                  Categories(),
                  const SizedBox(height: 24),
             Products(
                    title: 'Populer',
                    productType: ProductType.popular,
                  ),
                  const SizedBox(height: 24),
                Products(
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

class FragmentProduk extends StatelessWidget {
  const FragmentProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CheckoutScreen()),
        );
      },
      child: CheckoutScreen(),
    );
  }
}

class FavoriteScreen extends StatelessWidget {
  final List<Product> favorites;

  const FavoriteScreen({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorit'),
      ),
      body: Center(
        child: Text('Favorite Count: ${favorites.length}'),
      ),
    );
  }
}

class FragmentAkun extends StatelessWidget {
  const FragmentAkun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AkunScreen()),
        );
      },
      child: AkunScreen(),
    );
  }
}


