import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../API/Api_Service.dart';

import 'package:ecommerce_ui/constants.dart';
import '../../details_screen/details_screen.dart';

class Productsr extends StatefulWidget {
  final String title;
  final List<Productse> data;

  Productsr({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Productsr> {
  late Future<List<Productse>> listblog;
  List<Productse> listViews = [];

  Future<List<Productse>> fetchData() async {
    try {
      List<Productse> data = await ServiceApiAset().getData();
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
                Text(
                  product.merkBarang.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              if (product.harga != null)
                Text(
                  product.harga.toString(),
                  style: const TextStyle(
                    fontSize: 15,
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
              maxLines: 1,
              style: TextStyle(
                fontSize: 13,
                color: kSecondaryColor.withOpacity(0.6),
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
        height: 148,
        width: 148,
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

  Widget productItem(BuildContext context, Productse product) {
    String imageUrl = "http://192.168.6.51:8000/storage/" +
        product.gambar.toString();
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            width: 184,
            height: 200,
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
            child: Column(
              children: [
                background(product),
                const SizedBox(height: 12),
                text(product),
              ],
            ),
          ),

          // Image.network(

          //   imageUrl,
          //   height: 148,
          //   fit: BoxFit.cover,
          //   loadingBuilder: (context, child, loadingProgress) {
          //     if (loadingProgress == null) return child;
          //     return Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          //   errorBuilder: (context, error, stackTrace) {
          //     return Container(
          //       height: 148,
          //       color: Colors.grey,
          //     );
          //   },

          // ),
        ),
        //  Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Container(
        //     width: 184,
        //     height: 200,
        //           decoration: BoxDecoration(
        //                           border: Border.all(
        //                               width: 4,
        //                               color: Theme.of(context)
        //                                   .scaffoldBackgroundColor),
        //                           boxShadow: [
        //                             BoxShadow(
        //                                 spreadRadius: 2,
        //                                 blurRadius: 10,
        //                                 color: Colors.black.withOpacity(0.1),
        //                                 offset: Offset(0, 10))
        //                           ],
        //                           shape: BoxShape.circle,
        //                           image: DecorationImage(
        //                               fit: BoxFit.cover,
        //                               image: NetworkImage(
        //                                 "https://445e-103-160-182-11.ngrok-free.app/" + product.gambar.toString(),
        //                               ))),

        //     child: Column(

        //       children: [
        //         background(product),
        //         const SizedBox(height: 12),
        //         text(product),
        //       ],
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 184,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
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
        builder:
            (BuildContext context, AsyncSnapshot<List<Productse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
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
                crossAxisCount: data.length,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (BuildContext context, index) {
                return productItem(context, data[index]);
              },
            );
          }
        },
      ),
    );
  }
}
