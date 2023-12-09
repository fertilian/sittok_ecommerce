import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/BuyScreen/BuyPage.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/Total.dart';
import 'package:ecommerce_ui/models/getdataKeranjang.dart';
import 'package:ecommerce_ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce_ui/constants.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late Future<List<GetKeranjang>> listKeranjang;

  List<GetKeranjang> listViews = [];
  late Total _total;


  Future<List<GetKeranjang>> fetchData() async {
    try {
      List<GetKeranjang> data = await ServiceApiKeranjang().getData();
      Total total = await TotalService().getTotalJumlah();

      _total = total; // Assign the fetched Total object to _total
      listViews = data;
      return data;
    } catch (error) {
      // Handle error jika terjadi kesalahan saat mengambil data dari API
      print('Error fetching data: $error');
      throw Exception('Belum Ada Aset');
    }
  }

  @override
  void initState() {
    super.initState();
    listKeranjang = fetchData();
  }

  Widget appBar(BuildContext context) {
    return Positioned(
      left: 12,
      top: 52,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
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

  Widget text(GetKeranjang product, int index) {
    String jumlah = product.jumlah.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.merkBarang!,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Harga : " + "Rp." + product.harga.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Jumlah : " + "Rp." + listViews[index].jumlah.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget amountButton(GetKeranjang product, int index) {
    String qty = product.qty.toString();
    return Container(
      height: 36,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: kSecondaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              _handleMinQty(context, index);
              fetchData();
              getTotalJumlahs();
              setState(() {
                total.jumlah = total.jumlah;
              });
              setState(() {
                listViews[index].jumlah;
                setState(() {
                  total.jumlah = total.jumlah;
                });
              });

            },
            icon: const Icon(
              FontAwesomeIcons.minus,
              size: 10,
              color: kBackgroundColor,
            ),
          ),
          Text(
            listViews[index].qty.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
          IconButton(

            onPressed: () {
              _handleAddQty(context, index);
              getTotalJumlahs();
              fetchData(); // Panggil fetchData() setelah operasi selesai
              setState(() {
                total.jumlah = total.jumlah;
              });
              setState(() {
                listViews[index].jumlah;
                setState(() {
                  total.jumlah = total.jumlah;
                });
              });
            },
            icon: const Icon(
              FontAwesomeIcons.plus,
              size: 10,
              color: kBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }



  Widget image(GetKeranjang product) {
    String imagePath = "http://192.168.6.51:8000/storage/" + product.gambar!;

    return Positioned(
      left: 16,
      bottom: 2,
      child: Image.network(
        imagePath,
        height: 92,
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          // Tampilkan widget alternatif jika terjadi kesalahan saat memuat gambar
          return const Icon(
            Icons.error,
            size: 92,
          );
        },
      ),
    );
  }

  Widget item(BuildContext context, GetKeranjang product, int index) {
    String imagePath = "http://192.168.6.51:8000/storage/" + product.gambar.toString();

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 100, right: 0),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kPrimaryColor.withOpacity(0.2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  text(product, index),
                  const Spacer(),
                  amountButton(product, index),
                ],
              ),
            ),

            Positioned(
              left: 6,
              bottom: 4,
              child: Image.network(
                imagePath,
                height: 80,
                width: 80,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Tampilkan widget alternatif jika terjadi kesalahan saat memuat gambar
                  return const Icon(
                    Icons.error,
                    size: 92,
                  );
                },
              ),
            )
          ],
        )
    );
  }

  Widget cartItems(List<GetKeranjang> products) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 256),
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 120),
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemCount: products.length,
        itemBuilder: (context, index) => item(context, products[index], index),
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

  Widget cost(List<GetKeranjang> products, Total total) {
    final totalJumlah = products.fold<double>(
      0,
          (value, product) => value + (product.jumlah ?? 0),
    );

    return Positioned(
      left: 24,
      right: 24,
      bottom: 130,
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Divider(
            height: 48,
            thickness: 1,
            color: kSecondaryColor,
          ),
          costLine(
            'Total',
            'Rp.' + total.jumlah.toString(),
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
            getTotalJumlahs();
            Navigator.push(
              context,
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
    return Scaffold(
      body: FutureBuilder<List<GetKeranjang>>(
        future: listKeranjang,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Belum Ada Aset'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum Ada Aset'));
          } else {
            List<GetKeranjang> products = snapshot.data!;
            Total total = _total; // Use the fetched Total object here

            return Stack(
              children: [
                cartItems(products),
                cost(products, total), // Pass the Total object here
                checkoutButton(context),
                appBar(context),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> _handleAddQty(BuildContext context, int index) async {
    try {
      var response = await http.post(Uri.parse(ApiConnect.addQty), body: {
        "id_keranjang": listViews[index].idKeranjang.toString(),
      });

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final add_datafavorit = GetKeranjang.fromJson(jsonData);
        fetchData();

        setState(() {
          listViews[index].qty = add_datafavorit.qty;
          listViews[index].jumlah = add_datafavorit.jumlah;

          // Perbarui nilai jumlah pada objek listViews[index]
          // berdasarkan add_datafavorit.jumlah
          listViews[index].jumlah = add_datafavorit.jumlah;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Gagal Menambah",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _handleMinQty(BuildContext context, int index) async {
    try {
      var response = await http.post(Uri.parse(ApiConnect.minQty), body: {
        "id_keranjang": listViews[index].idKeranjang.toString(),
      });

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final min_datafavorit = GetKeranjang.fromJson(jsonData);
        fetchData();

        setState(() {
          listViews[index].qty = min_datafavorit.qty;
          listViews[index].jumlah = min_datafavorit.jumlah;

          // Perbarui nilai jumlah pada objek listViews[index]
          // berdasarkan min_datafavorit.jumlah
          listViews[index].jumlah = min_datafavorit.jumlah;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Gagal Mengurangi",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  late SessionManager _sessionManager;
  late Total total;



  void getTotalJumlahs() async {
    _sessionManager = SessionManager();
    total = Total();
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.total), body: {
        'idCust': idCustomerString
      });

      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = jsonDecode(response.body);
        final total = Total.fromJson(jsonData);

        setState(() {
          total.jumlah = total.jumlah;
          setState(() {
            total.jumlah = total.jumlah;
          });
        });


      } else {
        Fluttertoast.showToast(
          msg: "Gagal mendapatkan total jumlah",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
        msg: "Gagal mendapatkan total jumlah",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12,
      );
    }
  }


}
