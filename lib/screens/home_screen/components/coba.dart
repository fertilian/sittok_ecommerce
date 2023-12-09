
import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/BuyScreen/BuyPage.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/DetailJual.dart';
import 'package:ecommerce_ui/models/GetTransaksi_model.dart';
import 'package:ecommerce_ui/models/Total.dart';
import 'package:ecommerce_ui/models/getDataNota.dart';
import 'package:ecommerce_ui/models/getdataKeranjang.dart';
import 'package:ecommerce_ui/screens/home_screen/components/nota_screen.dart';
import 'package:ecommerce_ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ecommerce_ui/constants.dart';

class TrackingScreens extends StatefulWidget {
  final String title;
  final List<GetTransaksi> data;


  TrackingScreens({
    Key? key,
    required this.title,
    required this.data,

  }) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreens> {
  late Future<List<GetTransaksi>> listKeranjang;

  List<GetTransaksi> listViews = [];


  Future<List<GetTransaksi>> fetchData() async {
    try {
      List<GetTransaksi> data = await ServiceApiGetTrans().getData();


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
          const Text(
            'Pesanan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    )));
  }
Widget amountButton(GetTransaksi product, int index) {
  String status = listViews[index].status.toString();
  Color buttonColor = status == 'Selesai' ? Colors.white : kSecondaryColor;
  Color textColor = status == 'Selesai' ? kPrimaryColor : Colors.white;

  return InkWell(
    onTap: () {
      String idJual = listViews[index].idJual.toString();
      _handleNota(idJual);
    },
    child: Container(
      height: 36,
      width: 124,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: buttonColor,
      ),
      child: Center(
        child: Text(
          status,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}


void _handleNota(String idJual) async {
  try {
    ServiceApiNota serviceApiNota = ServiceApiNota(idJual);
    List<GetNota> data = await serviceApiNota.getData();

    // Lakukan tindakan dengan data nota yang diterima, misalnya menavigasi ke halaman nota
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotaScreen(notaData: data),
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





  Widget image(GetKeranjang product) {
    String imagePath =
        "http://192.168.6.51:8000/storage/" + product.gambar!;
    return Positioned(
      left: 16,
      bottom: 2,
      child: Image.network(
        imagePath,
        height: 92,
        errorBuilder: (BuildContext context, Object exception,
            StackTrace? stackTrace) {
          
          return const Icon(
            Icons.error,
            size: 92,
          );
        },
      ),
    );
  }
Widget item(BuildContext context, GetTransaksi product, int index) {

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: kPrimaryColor.withOpacity(0.2),
          ),
          child: Column(children: [
            Row(children: [
              Text("No Transaksi : " +
           listViews[index].idJual.toString() ,
            style:const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
           Text(
            
           listViews[index].createdAt!.substring(0, 10 ) ,
            style:const TextStyle(
              
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            
          ),
            ],),
            const Spacer(),
            Row(children : [
              Column(children:[
            Text(
           listViews[index].namaLengkap.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
             textAlign: TextAlign.start,
          ),
          
          Text(
           listViews[index].alamat.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
             textAlign: TextAlign.start,
          ),
          Text(
           listViews[index].nohp.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.start,
          ),]),
          const Spacer()
          ]),
          const Spacer(),

          Row(children: [
                        Text( "Total Bayar : Rp."+
           listViews[index].totalFinal.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
             textAlign: TextAlign.start,
          ),
          const Spacer(),
          amountButton(product, index)
          ],)
          ],)
        ),

      ],
    )
  );
}

Widget cartItems(List<GetTransaksi> products) {
  return Padding(
    padding: const EdgeInsets.only(bottom:6),
    child: ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemCount: products.length,
      itemBuilder: (context, index) => item(context, products[index], index),
    ),
  );
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: appBar(context),
    body: FutureBuilder<List<GetTransaksi>>(
      future: listKeranjang,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Belum Ada Aset'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Belum Ada Aset'));
        } else {
          List<GetTransaksi> products = snapshot.data!;
          Jual jual = Jual(); // Inisialisasi objek Jual
          Barang barang = Barang(); // Inisialisasi objek Barang

          return 

            cartItems(products);
       
              
          
        }
      },
    ),
  );
}


}


class ServiceApiNota {
  final String idJual;

  ServiceApiNota(this.idJual);

  Future<List<GetNota>> getData() async {
    try {
      final response = await http.post(Uri.parse(ApiConnect.getKlaim), body: {
        "id_jual": idJual,
      });
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<GetNota> data = jsonData.map((e) => GetNota.fromJson(e)).toList();
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




