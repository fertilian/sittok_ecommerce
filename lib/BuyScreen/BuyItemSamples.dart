import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:ecommerce_ui/constants.dart';
import 'package:ecommerce_ui/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyItemSamples extends StatefulWidget {
  @override
  _BuyItemSamplesState createState() => _BuyItemSamplesState();
}

class _BuyItemSamplesState extends State<BuyItemSamples> {
  late Future<List<Paymen>> listKeranjang;

  List<Paymen> listViews = [];

  Future<List<Paymen>> fetchData() async {
    try {
      List<Paymen> data = await ServiceApiPaymen().getData();

      listViews = data;
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
    listKeranjang = fetchData();
  }
  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Paymen>>(
      future: listKeranjang,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Data not found'));
        } else {
          List<Paymen> products = snapshot.data!;

          return Column(

            children:
            List.generate(
              products.length,
                  (index) => Container(
                height: 110,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Radio(
                      value: "",
                      groupValue: "",
                      activeColor: kSecondaryColor,
                      onChanged: (Index) {},
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      margin: EdgeInsets.only(right: 15),
                      child: Image.network(
                        "http://192.168.6.51:8000/storage/" +
                            products[index].icon.toString(),
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Icon(
                            Icons.error,
                            size: 92,
                          );
                        },
                      ),
                    ),const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            products[index].jenisPaymen.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            products[index].noPaymen.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),const Spacer(),
                    IconButton(onPressed: (){
                      copyToClipboard(
                          products[index].noPaymen.toString());
                    }, icon: const Icon(
                      FontAwesomeIcons.copy,
                      size: 25,
                      color: kDarkProductColor,
                    ),)
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
