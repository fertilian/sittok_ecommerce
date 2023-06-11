
import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:ecommerce_ui/screens/checkout_screen/checkout_screen.dart';
import 'package:ecommerce_ui/screens/favorite/favorite_screen.dart';
import 'package:ecommerce_ui/screens/home_screen/components/products.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/src/material/page.dart';
import 'package:get/get.dart';
import '../../models/product.dart';
import 'package:ecommerce_ui/constants.dart';
import 'package:ecommerce_ui/mocks/mock_data.dart';
import 'package:ecommerce_ui/controller/produk_controller.dart';

enum IconType {
  width,
  height,
  weight,
}

final ProductController controller = Get.put(ProductController());

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isFavorite = false;

  Widget circle() {
    return Stack(
      children: [
        Positioned(
          left: -196,
          top: -92,
          child: Container(
            width: 520,
            height: 520,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment(-0.5, -0.5),
                end: Alignment.bottomRight,
                colors: [
                  kLightProductColor,
                  kDarkProductColor,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  spreadRadius: 10,
                  color: kPrimaryColor.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: 84,
          child: Image.asset(
            widget.product.imagePath,
            height: 352,
          ),
        ),
      ],
    );
  }

  Widget sideButtons(BuildContext context) {
    return Positioned(
      top: 100,
      right: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              size: 28,
            ),
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  MockData.removeFromFavorites(widget.product);
                } else {
                  MockData.addToFavorites(widget.product);
                }
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget measurementIcon(IconType iconType, String text) {
    late final IconData iconData;
    switch (iconType) {
      case IconType.width:
        iconData = FontAwesomeIcons.arrowsLeftRight;
        break;
      case IconType.height:
        iconData = FontAwesomeIcons.arrowsUpDown;
        break;
      case IconType.weight:
        iconData = FontAwesomeIcons.weightHanging;
        break;
    }

    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kPrimaryColor.withOpacity(0.7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 28,
            color: kBackgroundColor,
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kBackgroundColor,
            ),
          ),
        ],
      ),
    );
  }
  Widget content() {
    return Positioned(
      left: 24,
      top: 452,
      right: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.product.description,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              measurementIcon(IconType.width, widget.product.width),
              measurementIcon(IconType.height, widget.product.height),
              measurementIcon(IconType.weight, widget.product.weight),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.product.priceString,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,

              // child:
              //
              // Container(
              //   color: kSecondaryColor,
              //   decoration: const BoxDecoration(
              //     color: kSecondaryColor,
              //     borderRadius: BorderRadius.only(
              //       topRight: Radius.circular(50),
              //       topLeft: Radius.circular(50),
              //     ),
              //   ),
              //
              //
              // ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(),
                    ),
                  );
                },

                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backButton(BuildContext context) {
    return Positioned(
      left: 12,
      top: 52,
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          FontAwesomeIcons.chevronLeft,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          circle(),
          sideButtons(context),
          content(),
          bottomBar(),
          backButton(context),
        ],
      ),
    );
  }
}

