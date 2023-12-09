import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/BuyScreen/BuyPage.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/DetailJual.dart';
import 'package:ecommerce_ui/models/GetTransaksi_model.dart';
import 'package:ecommerce_ui/models/Total.dart';
import 'package:ecommerce_ui/models/getDataNota.dart';
import 'package:ecommerce_ui/models/getdataKeranjang.dart';
import 'package:ecommerce_ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ecommerce_ui/constants.dart';

class TrackingScreen extends StatefulWidget {
  final String title;
  final List<GetTransaksi> data;
  final int index;

  TrackingScreen({
    Key? key,
    required this.title,
    required this.data,
    required this.index
  }) : super(key: key);

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  late Future<List<GetTransaksi>> listKeranjang;
   late Future<List<GetNota>> listNota;

  List<GetTransaksi> listViews = [];
   List<GetNota> listGetDetail = [];


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


Future<void> fetchDataNota(int index) async {
  try {
    final response = await http.post(Uri.parse(ApiConnect.getKlaim), body: {
      'id_jual': listViews[index].idJual.toString(),
    });

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonData = jsonDecode(response.body);
      List<GetNota> data = jsonData.map((e) => GetNota.fromJson(e)).toList();

      setState(() {
        listGetDetail = data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print(e.toString());
    throw Exception('Failed to load data');
  }
}




@override
void initState() {
  super.initState();
  listKeranjang = fetchData();
 fetchDataNota(widget.index);
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
    );
  }

  Widget amountButton(GetTransaksi product, int index) {
    return InkWell(
      onTap: () {
       getData(index);
       fetchDataNota(index);
      },
      child: Container(
        height: 36,
        width: 124,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: kSecondaryColor,
        ),
        child: Center(
          child: Text(
            listViews[index].status.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

    Widget buyButton(GetNota product, int index) {
    return InkWell(
      onTap: () {
        
      },
      child: Container(
        height: 36,
        width: 124,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: kSecondaryColor,
        ),
        child: Center(
          child: Text(
            listViews[index].status.toString(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget image(GetKeranjang product) {
    String imagePath =
        "https://a4bc-103-213-128-157.ngrok-free.app/" + product.gambar!;

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

Widget listnota(BuildContext context, GetNota product, int index) {
String imagePath = "https://a4bc-103-213-128-157.ngrok-free.app/" + product.gambar.toString();
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
                 const Spacer(),
              Text("Harga: " +
           listGetDetail[index].harga.toString() ,
            style:const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            ),
          ),
       
            ],),
            const Spacer(),
            Row(children : [

 Image.network(
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

              Column(children:[
            Text(
           listGetDetail[index].merkBarang.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
             textAlign: TextAlign.start,
          ),
          
          Text(
           listGetDetail[index].deskripsi.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          ]),
          const Spacer()
          ]),
          const Spacer(),

          Row(children: [
            const Spacer(),

            Column(children:[

         Text(
          "X" + listGetDetail[index].qty.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          Text(
          "X" + listGetDetail[index].jumlah.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          
          ],)
          ],)
      ])),

      ],
    )
  );
}



Widget cartItems(List<GetTransaksi> products) {
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

Widget cartItemNota(List<GetNota> products) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 256),
    child: ListView.separated(
      padding: const EdgeInsets.only(top: 120),
      separatorBuilder: (_, __) => const SizedBox(height: 24),
      itemCount: products.length,
      itemBuilder: (context, index) => listnota(context, products[index], index),
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

          return Stack(
            children: [
              cartItems(products),
              // cost(products, total), // Pass the Total object here
              // checkoutButton(context),
              appBar(context),
            ],
          );
        }
      },
    ),
  );
}





late SessionManager _sessionManager;
late Total total;
Future<void> _handleNota(BuildContext context, int index) async {
  try {
    var response = await http.post(Uri.parse(ApiConnect.getNota), body: {
      "id_jual": listViews[index].idJual.toString(),
    });

    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final getNota = GetTransaksi.fromJson(jsonData);
   
    //  bayar(context,jual, barang, index);

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
 
Future<void> bayar(BuildContext context, int index) async {

  await  showDialog(context: context,
                  builder: (context) {
                    return Dialog(
                      child:  Container(
                        
                        padding: EdgeInsets.all(0),

child:  Scaffold(
    body: Column(
  children: [
    Row(
      children :[

        Image.asset(
    'assets/images/sittoklogo.png',
    width: 44,  // Sesuaikan ukuran gambar
    height: 44,
  ),
  const Spacer(),
      const  Text(
                 "Daftar Barang",
                  style:  TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                 const Spacer(),
      ]),
      Row(children: [
        const Spacer(),
        Text(
                 "No Transaksi : "+listViews[index].idJual.toString(),
                  style:  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(175, 76, 83, 165),
                  ),
                ),
      ],),
      Row(children: [
        const Spacer(),
        Text(
                 listGetDetail[index].createdAt!.substring(0,10),
                  style:  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                   color: Color.fromARGB(175, 76, 83, 165),
                  ),
                ),
      ],),
        Row(children: [
        Column(children : [
        Text(
                 listViews[index].namaLengkap.toString(),
                  style:  const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                 Text(
                 listViews[index].alamat.toString(),
                  style:  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(175, 76, 83, 165),
                  ),
                ),
                 Text(
                 listViews[index].nohp.toString(),
                  style:  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(175, 76, 83, 165),
                  ),
                ),
                

                
                ])
      ],),
      FutureBuilder<List<GetNota>>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Belum Ada Aset'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Belum Ada Aset'));
        } else {
          List<GetNota> products = snapshot.data!;
          

          return Stack(
            children: [
             Padding(
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
                 const Spacer(),
              Text("Harga: " +
           listGetDetail[index].harga.toString() ,
            style:const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            ),
          ),
       
            ],),
            const Spacer(),
            Row(children : [

 Image.network(
      "https://a4bc-103-213-128-157.ngrok-free.app/" + listGetDetail[index].gambar!.toString(),
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

              Column(children:[
            Text(
           listGetDetail[index].merkBarang.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
             textAlign: TextAlign.start,
          ),
          
          Text(
           listGetDetail[index].deskripsi.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          ]),
          const Spacer()
          ]),
          const Spacer(),

          Row(children: [
            const Spacer(),

            Column(children:[

         Text(
          "X" + listGetDetail[index].qty.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          Text(
          "X" + listGetDetail[index].jumlah.toString() ,
            style:const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          
          ],)
          ],)
      ])),

      ],
    )
  )
          
            ],
          );
        }
      },
    ),
        Row(children: [
        const Spacer(),
        Text(
                 listViews[index].totalFinal.toString(),
                  style:  const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                   color: Color.fromARGB(175, 76, 83, 165),
                  ),
                ),
      ],),

Container(
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
  ],
),
  )
  
  
  
  ));});
}

Future<List<GetNota>> getData(int index) async {
  try {
    final response = await http.post(Uri.parse(ApiConnect.getKlaim),
        body: {
          'id_jual': listViews[index].idJual.toString(),
        }
    );
    if (response.statusCode == 200) {
      await fetchDataNota(index); // Await the fetchDataNota function

      print(response.body);
      List<dynamic> jsonData = jsonDecode(response.body);
      List<GetNota> data = jsonData.map((e) => GetNota.fromJson(e)).toList();
      bayar(context, index);
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
