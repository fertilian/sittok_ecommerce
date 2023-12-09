import 'dart:convert';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/GetDetilBarang.dart';
import 'package:ecommerce_ui/models/GetKategori.dart';
import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:ecommerce_ui/models/model_datakeranjang.dart';
import 'package:ecommerce_ui/screens/checkout_screen/checkout_screen.dart';
import 'package:ecommerce_ui/screens/home_screen/components/detail_barang.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../API/Api_Service.dart';
import 'package:ecommerce_ui/constants.dart';
import '../../../API/Api_connect.dart';

class Products extends StatefulWidget {
  final String title;
  final List<Productse> data;

  Products({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Productse>> listblog;
  late Future<List<Kategori>> listkategori;
  late Map<int, bool> isLiked = {};

  List<Productse> listViews = [];
  List<Kategori> _list = [];
  List<Productse> originalListViews = [];

  Future<List<Productse>> fetchData() async {
    try {
      // Ambil data dari ServiceApiAset
      List<Productse> responseData = await ServiceApiAset().getData();

      // Setel state dan kembalikan data
      setState(() {
        listViews = responseData;
        originalListViews = List.from(listViews);
        isLiked = Map<int, bool>.fromIterable(listViews,
            key: (e) => e.idBarang, value: (e) => e.isLiked);
      });

      // Kembalikan data yang berhasil diambil
      return listViews;
    } catch (error) {
      // Tangkap dan cetak pesan kesalahan, lalu lempar pengecualian
      print('Error fetching dataaaa: $error');
      throw Exception('Failed to load daaaata');
    }
  }

  Future<List<Kategori>> fetchData2() async {
    try {
      List<Kategori> kategori = await ServiceApiKategori().getData();
      setState(() {
        _list = kategori;
      });
      return kategori;
    } catch (error) {
      // Handle error jika terjadi kesalahan saat mengambil data dari API
      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    listblog = fetchData();
    listkategori = fetchData2();
  }

  void updateList(String value) {
    setState(() {
      if (value.isEmpty) {
        // Kembalikan data asli jika value kosong
        listViews = widget.data.toList();
      } else {
        // Cari data yang cocok dengan value
        listViews = widget.data
            .where((element) =>
        element.merkBarang!
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            element.deskripsi!
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            element.idKategori!
                .toString()
                .toLowerCase()
                .contains(value.toLowerCase()) ||
            element.harga!.toString().contains(value))
            .toList();

        // Menghitung jumlah kemunculan kata kunci dalam setiap elemen data
        listViews.sort((a, b) {
          int countA = (a.merkBarang!
              .toLowerCase()
              .split(value.toLowerCase())
              .length -
              1) +
              (a.deskripsi!.toLowerCase().split(value.toLowerCase()).length -
                  1);
          int countB = (b.merkBarang!
              .toLowerCase()
              .split(value.toLowerCase())
              .length -
              1) +
              (b.deskripsi!.toLowerCase().split(value.toLowerCase()).length -
                  1);
          return countB.compareTo(countA);
        });
      }

      if (listViews.isEmpty) {
        // Set listViews menjadi kosong jika hasil pencarian tidak ditemukan
        listViews = [];
      }
    });
  }

  Widget background(Productse product) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            kPrimaryColor.withOpacity(0.2),
            kPrimaryColor.withOpacity(0.6),
          ],
        ),
      ),
    );
  }

  Widget text(Productse product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (product.merkBarang != null && product.merkBarang!.isNotEmpty)
                Text(
                  product.merkBarang.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              if (product.harga != null)
                Text(
                  product.harga.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          if (product.deskripsi != null && product.deskripsi!.isNotEmpty)
            Text(
              product.deskripsi.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: 9,
                color: kSecondaryColor.withOpacity(0.9),
              ),
            ),
        ],
      ),
    );
  }

  Widget image(Productse product) {
    if (product.gambar != null) {
      String imageUrl = "http://192.168.6.51:8000/storage/" +
          product.gambar.toString();
      return Container(
        height: 128,
        width: 128,
        color: Colors.grey,
        decoration: BoxDecoration(
            border: Border.all(
                width: 4, color: Theme.of(context).scaffoldBackgroundColor),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 10))
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "http://192.168.6.51:8000/storage/" +
                      product.gambar.toString(),
                ))),
        child: text(product),
      );
    } else {
      return Container(
        height: 120,
        color: Colors.grey,
      );
    }
  }

  Widget favoriteIcon(int index) {
    int? productId = listViews[index].idBarang;
    bool isProductLiked = isLiked[productId] ?? false;
    return Positioned(
      top: 0,
      right: 0,
      child: listViews[index].isLiked! == true
          ? Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topRight: Radius.circular(20),
            ),
            color: Colors.blueAccent),
        child: IconButton(
          onPressed: () {
            setState(() {
              isLiked[productId!] = !isProductLiked;
            });
            _handledeleteData(context, index);
            fetchData();
          },
          icon: Icon(
            FontAwesomeIcons.heart,
            size: 24,
            color: Colors.white,
          ),
        ),
      )
          : Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topRight: Radius.circular(20),
            ),
            color: Colors.white),
        child: IconButton(
          onPressed: () {
            setState(() {
              isLiked[productId!] = !isProductLiked;
            });
            _handleAdddatafavorit(context, index);
            fetchData();
          },
          icon: Icon(
            FontAwesomeIcons.heart,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget productItem(BuildContext context, Productse product, int index) {
    String imageUrl = "http://192.168.6.51:8000/storage/" +
        product.gambar.toString();
    return Stack(
      children: [
        InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              String idBarang = widget.data[index].idBarang.toString();
              _handleBarang(idBarang);
            },
            child: Container(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 93),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 148,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    _handleAdddatakeranjang(context, index);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Ajukan Sewa',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        favoriteIcon(index),
      ],
    );
  }

  int selectedIndex = 0;
  TextEditingController searchController = TextEditingController();
  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56), // Sesuaikan dengan ketinggian yang diinginkan
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false, // Untuk menghapus tombol kembali di AppBar
          ),
          Positioned(
            left: 16,
            right: 16,
            child: TextField(
              onChanged: (value) => updateList(value),
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: FutureBuilder<List<Productse>>(
        future: listblog,
        builder:
            (BuildContext context, AsyncSnapshot<List<Productse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Productse> data = snapshot.data!;

            if (listViews.isEmpty) {
              return const Center(
                child: Text('Tidak ada hasil pencarian.'),
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.only(
                    top: 16, right: 16, left: 16, bottom: 16),
                itemCount: listViews.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 50,
                ),
                itemBuilder: (BuildContext context, index) {
                  return Column(children: [
                    productItem(context, listViews[index], index),
                    const SizedBox(
                      height: 2,
                    ),
                    text(listViews[index])
                  ]);
                },
              );
            }
          }
        },
      ),
    );
  }

  late SessionManager _sessionManager;

  Future<void> _handleAdddatakeranjang(BuildContext context, int index) async {
    _sessionManager = SessionManager();

    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';

      final response = await http.post(Uri.parse(ApiConnect.add_datakeranjang), body: {
        "idCust": idCustomerString,
        "idAset": listViews[index].idBarang.toString(),
        "qty": "1",
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final add_datakeranjang = AddChart.fromJson(jsonData);

        if (add_datakeranjang.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CheckoutScreen()),
          );
        } else {
          Fluttertoast.showToast(
            msg: add_datakeranjang.message ?? "Data Gagal masuk Keranjang",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Gagal",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
      Fluttertoast.showToast(
        msg: "Terjadi kesalahan",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12,
      );
    }
  }

  Future<void> _handleAdddatafavorit(BuildContext context, int index) async {
    _sessionManager = SessionManager();

    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';

      final response = await http.post(Uri.parse(ApiConnect.add_datafavorit), body: {
        "idCust": idCustomerString,
        "idAset": listViews[index].idBarang.toString(),
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final add_datafavorit = AddChart.fromJson(jsonData);

        // Set status favorit menjadi true jika berhasil
        setState(() {
          isLiked[index] = true;
        });
      } else {
        Fluttertoast.showToast(
          msg: "Data Gagal masuk Keranjang",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  Future<void> _handledeleteData(BuildContext context, int index) async {
    _sessionManager = SessionManager();

    SessionManager.getIdCustomer().then((idCustomer) {
      var idCustomerString = idCustomer?.toString() ?? '';

      http.post(Uri.parse(ApiConnect.del_datafavorit), body: {
        "idCust": idCustomerString,
        "idAset": listViews[index].idBarang.toString(),
      }).then((response) {
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final add_datafavorit = AddChart.fromJson(jsonData);
          if (response.statusCode == 200) {
            // Set status favorit menjadi true jika berhasil
            setState(() {
              isLiked[index] = true;
            });
          } else {
            Fluttertoast.showToast(
              msg: "Data Gagal masuk Keranjang",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 12,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: idCustomerString,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      }).catchError((error) {
        // Handle error
        print('Error: $error');
      });
    });
  }

  void _handleBarang(String idBarang) async {
    try {
      ServiceApiDetilBarang serviceApiNota = ServiceApiDetilBarang(idBarang);
      GetDetilBarang data = await serviceApiNota.getData();

      // Lakukan tindakan dengan data nota yang diterima, misalnya menavigasi ke halaman nota
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetilBarang(notaData: data),
        ),
      );
    } catch (error) {
      // Tangani kesalahan jika terjadi kesalahan saat mengambil data nota
      print('Error fetching nota data: $error');
      // Tampilkan pesan kesalahan kepada pengguna
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Gagal memuat data nota.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class ServiceApiDetilBarang {
  final String idBarang;

  ServiceApiDetilBarang(this.idBarang);

  Future<GetDetilBarang> getData() async {
    try {
      final response =
      await http.post(Uri.parse(ApiConnect.detilbarang), body: {
        "idAset": idBarang,
      });
      if (response.statusCode == 200) {
        print(response.body);
        dynamic jsonData = jsonDecode(response.body);
        GetDetilBarang data = GetDetilBarang.fromJson(jsonData);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}
