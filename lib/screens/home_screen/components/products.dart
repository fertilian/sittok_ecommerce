import 'dart:convert';

import 'package:ecommerce_ui/Screen/Login/login_screen.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:ecommerce_ui/models/model_datakeranjang.dart';
import 'package:ecommerce_ui/models/model_user.dart';
import 'package:ecommerce_ui/screens/checkout_screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../API/Api_Service.dart';


import 'package:ecommerce_ui/constants.dart';
import '../../../API/Api_connect.dart';
import '../../details_screen/details_screen.dart';


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
  List<Productse> listViews = [];

  Future<List<Productse>> fetchData() async {

    try {
      List<Productse> data = await ServiceApiBarang().getData();
      setState(() {
        listViews = data;
      });
      return data;
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
  }
  void fetchDataAndHandleAddDataKeranjang(BuildContext context, int index) async {
    final Users? users = await SessionManager.getUserData();
    if (users != null && users.idCustomer != null) {
      _handleAdddatakeranjang(context, index, users);
    } else {
      // Handle the scenario when user data is not available or user is not logged in
      Fluttertoast.showToast(
        msg: "Anda harus login terlebih dahulu",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (product.merkBarang != null && product.merkBarang!.isNotEmpty)
                Text("\n \n \n"+
                    product.merkBarang.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              if (product.harga != null)
                Text(
                  "\n \n \n"+
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

  Widget image(Productse product) {
    if (product.gambar != null) {
      String imageUrl =
          "https://2637-114-5-104-99.ngrok-free.app/" + product.gambar.toString();
      return Container(
        height: 148,
        width: 148,
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
                  "https://2637-114-5-104-99.ngrok-free.app/" + product.gambar.toString(),
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



  Widget favoriteIcon() {
    return Positioned(
      top: 20,
      right: 0,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            topRight: Radius.circular(20),
          ),
          color: Colors.white60,
        ),
        child: const Icon(
          FontAwesomeIcons.heart,
          size: 24,
        ),
      ),
    );
  }
  Widget productItem(BuildContext context, Productse product, int index, Users? users) {
    String imageUrl =
        "https://2637-114-5-104-99.ngrok-free.app/" + product.gambar.toString();
    return Stack(

      children: [
        Positioned.fill(
            child: Container(

              color: Colors.white,
              child:Column(
                  children :[
                    Image.network(
                      imageUrl,
                      height: 148,
                      fit: BoxFit.cover,

                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 148,
                          color: Colors.grey,
                        );
                      },
                    ),
                    const SizedBox(height: 5,),
                    text(product)
                  ]),)
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 184,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                 _handleAdddatakeranjang(context, index, users);
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        favoriteIcon(),

      ],
    );



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Productse>>(
        future: listblog,
        builder: (BuildContext context, AsyncSnapshot<List<Productse>> snapshot) {
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
            return GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 100,
              ),
              itemBuilder: (BuildContext context, index) {
                return productItem(context, data[index], index, users);
              },
            );
          }
        },
      ),
    );
  }


  Future<void> _handleAdddatakeranjang(BuildContext context, int index, Users users) async {


    try{

      var response = await http.post(Uri.parse(ApiConnect.add_datakeranjang), body: {
      "id_customer":
      users.idCustomer.toString(),
      "id_barang":
      listViews[index].idBarang.toString(),
      "qty" :"1".toString()
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final add_datakeranjang = AddChart.fromJson(jsonData);
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CheckoutScreen()),
          );
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
          msg:"Sukurinnnnn",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
      }catch (e) {
      // Handle error
      print('Error: $e');
    }
      }
}