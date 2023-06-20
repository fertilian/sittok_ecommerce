import 'package:ecommerce_ui/BuyScreen/BuyBottomNavBar.dart';
import 'package:ecommerce_ui/BuyScreen/BuyItemSamples.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/BuyScreen/BuyAppBar.dart';
import 'package:flutter/rendering.dart';

class BuyPage extends StatelessWidget {
  const BuyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BuyProduct(),

          Container(
            //t
            height: 900,
            padding: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: Column(children: [
              BuyItemSamples()


            ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BuyBottomNavBar(),
    );
  }
}
