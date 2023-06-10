import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../API/Api_Service.dart';
import '../../../mocks/mock_data.dart';
import '../../../models/product.dart';
import 'package:ecommerce_ui/constants.dart';
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

  Widget background(Productse barang) {
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

  Widget text(Productse barang) {
    Productse? data = barang;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (data?.merkBarang != null && data!.merkBarang!.isNotEmpty)
                Text(
                  data.merkBarang!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const Spacer(),
              if (data?.harga != null)
                Text(
                  data!.harga.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          if (data?.deskripsi != null && data!.deskripsi!.isNotEmpty)
            Text(
              data!.deskripsi!,
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

  Widget image(String imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      String imageUrl = "https://0a6c-180-253-160-53.ngrok-free.app$imagePath"; // Replace "your-server-link.com" with the actual server link
      return Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Image.network(
          imageUrl,
          height: 148,
        ),
      );
    } else {
      return Container(
        height: 148,
        color: Colors.grey, // Placeholder color or any other representation
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

  Widget productItem(BuildContext context, Productse barang) {
    Productse? data = barang;

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 184,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFCFCFC),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 50,
                  color: Color(0x40AFAFAF),
                ),
              ],
            ),
            child: Column(
              children: [
                background(barang),
                const SizedBox(height: 12),
                text(barang),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Image.network(
            data?.gambar ?? '',
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
        ),
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
                mainAxisSpacing: 16,
              ),
              itemBuilder: (BuildContext context, int index) {
                return productItem(context, data[index]);
              },
            );
          }
        },
      ),
    );
  }


}