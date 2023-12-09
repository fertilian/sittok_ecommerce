import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/constants.dart';
import 'package:ecommerce_ui/models/GetDetilBarang.dart';
import 'package:ecommerce_ui/models/model_datakeranjang.dart';
import 'package:ecommerce_ui/screens/home_screen/components/products.dart';
import 'package:ecommerce_ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetilBarang extends StatefulWidget {
  GetDetilBarang notaData;
  DetilBarang({Key? key, required this.notaData}) : super(key: key);

  @override
  _DetilBarangState createState() => _DetilBarangState();
}

class _DetilBarangState extends State<DetilBarang> {

  late GetDetilBarang listNota;
  late Map<int, bool> isLiked = {};



  @override
  void initState() {
    super.initState();
    fetchData(0); // Menggunakan indeks 0 sebagai contoh, gantilah dengan indeks yang sesuai
  }

  Future<void> fetchData(int index) async {
    try {
      String idBarang = widget.notaData.idBarang.toString();
      GetDetilBarang data = await ServiceApiDetilBarang(idBarang).getData();
      setState(() {
        listNota = data;
        isLiked = {index: data.isLiked!}; // Menggunakan index sebagai key pada isLiked
      });
    } catch (error) {
      // Tangani kesalahan jika terjadi kesalahan saat mengambil data dari API
      print('Error fetching data: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gagal Memuat Data'),
            content: Text('Terjadi kesalahan saat memuat data.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }



  Widget favoriteIcon(index) {
    int? productId = widget.notaData.idBarang;
    bool isProductLiked = isLiked[productId] ?? false;
    return Positioned(
      top: 10,
      right: 10,
      child:

      widget.notaData.isLiked == true ?
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topRight: Radius.circular(20),

            ),
            color :  Colors.blueAccent
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              widget.notaData.isLiked = false;
              fetchData(index);
            });
            _handledeleteData(context);
            fetchData(index);
          },
          icon: Icon(
            FontAwesomeIcons.heart,
            size: 24,
            color:  Colors.white ,
          ),
        ),
      ) :
      Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topRight: Radius.circular(20),

            ),
            color :  Colors.white
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              widget.notaData.isLiked = true;
              fetchData(index);
            });
            _handleAdddatafavorit(context, index);
            fetchData(index);
          },
          icon: const Icon(
            FontAwesomeIcons.heart,
            size: 24,
            color: Colors.black,
          ),
        ),
      )
      ,
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(56), // Sesuaikan dengan ketinggian yang diinginkan

        child:
        Padding (padding: EdgeInsets.only(top: 20),child :
        Positioned(
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
                  Icons.chevron_left,
                ),
              ),
              Text(
                widget.notaData.merkBarang.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )));
  }

  Widget image(GetDetilBarang product) {
    if (product.gambar != null) {
      String imageUrl =
          "http://192.168.6.51:8000/storage/" + widget.notaData.gambar.toString();
      return Container(
        height: 128,
        width: 128,
        color: Colors.grey,

        decoration: BoxDecoration(
            border: Border.all(
                width: 4,
                color: Theme.of(context)
                    .scaffoldBackgroundColor),
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
                  "http://192.168.6.51:8000/storage/" + widget.notaData.gambar.toString(),
                ))),

      );
    } else {
      return Container(
        height: 120,
        color: Colors.grey,
      );
    }
  }
  Widget text(GetDetilBarang product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 150,),
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
          Row(children: [
            const Spacer(),
            Text(

              product.jumlahBarang.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],),
          if (product.deskripsi != null && product.deskripsi!.isNotEmpty)
            Text(
              product.deskripsi.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              style: TextStyle(
                fontSize: 9,
                color: kSecondaryColor.withOpacity(0.9),
              ),
            ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    int index;
    String imageUrl =
        "http://192.168.6.51:8000/storage/" + widget.notaData.gambar.toString();
    GetDetilBarang product;
    return Scaffold(
      appBar: appBar(context),
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child:
        Image.network(
            imageUrl,
            alignment: Alignment.center,
            height: 230,
            fit: BoxFit.cover,

            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 128,
                color: Colors.grey,
              );
            },
        ),
        ),
        favoriteIcon(0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 250,),
              Row(
                children: [
                  if (widget.notaData.merkBarang != null && widget.notaData.merkBarang!.isNotEmpty)
                    Text(
                      widget.notaData.merkBarang.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const Spacer(),
                  if (widget.notaData.harga != null)
                    Text(

                      "Harga : "  + widget.notaData.harga.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 4),
              Row(children: [

                Text(

                  "Stok : "+     widget.notaData.jumlahBarang.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],),

              if (widget.notaData.deskripsi != null && widget.notaData.deskripsi!.isNotEmpty)
                Text(
                  widget.notaData.deskripsi.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight:  FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        )


      ]),

    );}

  Future<void> _handleAdddatafavorit(BuildContext context, int index) async {
    _sessionManager = SessionManager();

    SessionManager.getIdCustomer().then((idCustomer) {
      var idCustomerString = idCustomer?.toString() ?? '';
      http.post(Uri.parse(ApiConnect.add_datafavorit), body: {
        "idCust": idCustomerString,
        "idAset": widget.notaData.idBarang.toString(),
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

  late SessionManager _sessionManager;
  Future<void> _handledeleteData(BuildContext contex) async {
    _sessionManager = SessionManager();

    SessionManager.getIdCustomer().then((idCustomer) {
      var idCustomerString = idCustomer?.toString() ?? '';
      http.post(Uri.parse(ApiConnect.del_datafavorit), body: {
        "idCust": idCustomerString,
        "idAset": widget.notaData.idBarang.toString(),
      }).then((response) {
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final add_datafavorit = AddChart.fromJson(jsonData);
          if (response.statusCode == 200) {
            setState(() {
              isLiked[0] = true;
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
}