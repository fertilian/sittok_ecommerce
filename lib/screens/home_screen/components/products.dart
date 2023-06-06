import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../mocks/mock_data.dart';
import '../../../models/product.dart';
import 'package:ecommerce_ui/constants.dart';
import '../../details_screen/details_screen.dart';

class Products extends StatelessWidget {
  final String title;
  final ProductType productType;

  const Products({
    Key? key,
    required this.title,
    required this.productType,
  }) : super(key: key);

  Widget background(Product product) {
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

  Widget text(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                product.priceString,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            product.description,
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
      child: Image.asset(
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

  Widget productItem(BuildContext context, Product product) {
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
                background(product),
                const SizedBox(height: 12),
                text(product),
              ],
            ),
          ),
        ),
        image(product.imagePath),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: 184,
              height: 200,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(product: product),
                      ),
                    );
                  },
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
    final productList = MockData.getProducts(productType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(width: 24),
            itemCount: productList.length,
            itemBuilder: (_, index) => productItem(context, productList[index]),
          ),
        ),
      ],
    );
  }
}
