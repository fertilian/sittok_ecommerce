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
  final ProductType productType;

  Products({
    Key? key,
    required this.title,
    required this.productType,
  }) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<Data>> listblog;
  List<Data> listViews = [];

  @override
  void initState() {
    super.initState();
    listblog = ServiceApiBarang().getData() as Future<List<Data>>;
    listblog.then((value) {
      setState(() {
        listViews = value;
      });
    });
  }

  Widget background(Data data) {
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

  Widget text(Data data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                data.merkBarang ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                data.harga.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            data.deskripsi ?? '',
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
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Image.network(
        imagePath,
        height: 148,
      ),
    );
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
  Widget productItem(BuildContext context, Data data) {
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
                background(data),
                const SizedBox(height: 12),
                text(data),
              ],
            ),
          ),
        ),
        image(data.gambar ?? ''),
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
      body: FutureBuilder<List<Data>>(
        future: listblog,
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return GridView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (BuildContext context, int index) {
                return productItem(context, snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}