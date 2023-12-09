import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:ecommerce_ui/Akun/Akun_body.dart';
import 'package:ecommerce_ui/Akun/Akun_pic.dart';
import 'package:ecommerce_ui/Akun/Akun_screen.dart';
import 'package:ecommerce_ui/models/GetTransaksi_model.dart';
import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:ecommerce_ui/models/model_favorit.dart';
import 'package:ecommerce_ui/models/model_user.dart';
import 'package:ecommerce_ui/screens/favorite/favorite_screen.dart';
import 'package:ecommerce_ui/navBar/navBar.dart';
import 'package:ecommerce_ui/screens/home_screen/components/coba.dart';
import 'package:ecommerce_ui/screens/home_screen/components/favorit.dart';
import 'package:ecommerce_ui/screens/home_screen/components/productsr.dart';
import 'package:ecommerce_ui/screens/home_screen/components/tracking.dart';
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

  List<GetDataFav> favorites = [];

  List<Widget> _fragments = [
    FragmentBeranda(),
    const FragmentProduk(),
    FavoriteScreens(
      favorites: [],
    ),
    FragmentAkun(),
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
          // if (index == 2) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (_) => FavoriteScreens(favorites: favorites),
          //     ),
          //   );
          // }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blueAccent),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, color: Colors.blueAccent),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.blueAccent),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.blueAccent),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}

class FragmentBeranda extends StatefulWidget {
  FragmentBeranda({Key? key}) : super(key: key);
  @override
  _FragmentBerandaState createState() => _FragmentBerandaState();
}

class _FragmentBerandaState extends State<FragmentBeranda> {
  List<Productse> data = []; // Variabel untuk menyimpan data produk
  List<Productse> searchResults = []; // State untuk menampung hasil pencarian
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Productse> products = await ServiceApiAset().getData();
    setState(() {
      data = products;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchProducts(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        searchResults = [];
        isSearching = false;
      });
    } else {
      List<Productse> results = data.where((product) {
        return product.merkBarang!
            .toLowerCase()
            .contains(keyword.toLowerCase());
      }).toList();

      results.sort((a, b) {
        int differenceA =
        (a.merkBarang!.toLowerCase().length - keyword.length).abs();
        int differenceB =
        (b.merkBarang!.toLowerCase().length - keyword.length).abs();

        return differenceA.compareTo(differenceB);
      });

      setState(() {
        searchResults = results;
        isSearching = true;
      });
    }
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(
          56), // Sesuaikan dengan ketinggian yang diinginkan
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 52, 12, 0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Tindakan yang dijalankan saat gambar di-tap
              },
              child: Image.asset(
                'assets/images/salamberdiri.png',
                width: 44, // Sesuaikan ukuran gambar
                height: 44,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Selamat Datang di PDAM Surya Sembada',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
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
      ),
    );
  }

  Widget title() {
    return const Padding(
      padding: EdgeInsets.only(left: 24, right: 100),
      child: Text(
        'Selamat Datang di PDAM Surya Sembada',
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
          controller: searchController,
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
            prefixIcon: const Icon(FontAwesomeIcons.search),
          ),
          onChanged: searchProducts,
        ),
      ),
    );
  }

  Widget gass() {
    return FutureBuilder<List<Productse>>(
      future: ServiceApiAset().getData(),
      builder: (BuildContext context, AsyncSnapshot<List<Productse>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('No data available.'),
          );
        } else {
          List<Productse> data = snapshot.data!;
          return Expanded(
            child: isSearching && searchResults.isNotEmpty
                ? Products(
              title: 'Hasil Pencarian',
              data: searchResults,
            )
                : Products(
              title: 'Produk',
              data: data,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: isSearching && searchResults.isNotEmpty
                    ? Products(
                  title: 'Hasil Pencarian',
                  data: searchResults,
                )
                    : Products(
                  title: 'Produk',
                  data: data,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FragmentP extends StatelessWidget {
  const FragmentP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Productse>>(
        future: ServiceApiAset().getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Productse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available.'),
            );
          } else {
            List<Productse> data = snapshot.data!;
            return Productsr(
              title: 'Produk',
              data: data,
            );
          }
        },
      ),
    );
  }
}

class FragmentProduk extends StatelessWidget {
  const FragmentProduk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GetTransaksi>>(
        future: ServiceApiGetTrans().getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<GetTransaksi>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available.'),
            );
          } else {
            List<GetTransaksi> data = snapshot.data!;
            int index = 0;
            return TrackingScreens(
              title: 'Riwayat',
              data: data,
            );
          }
        },
      ),
    );
  }
}

class FavoriteScreens extends StatelessWidget {
  final List<GetDataFav> favorites;

  const FavoriteScreens({Key? key, required this.favorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GetDataFav>>(
        future: ServiceApiFavorit().getData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<GetDataFav>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available.'),
            );
          } else {
            List<GetDataFav> data = snapshot.data!;
            return ProductF(
              title: 'Produk',
              data: data,
            );
          }
        },
      ),
    );
  }
}

class FragmentAkun extends StatelessWidget {
  const FragmentAkun({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Users>(
        future: ServiceApiProfil().getData(),
        builder: (BuildContext context, AsyncSnapshot<Users> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No data available.'),
            );
          } else {
            Users data = snapshot.data!;
            return AkunPic();
          }
        },
      ),
    );
  }
}
