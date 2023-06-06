import 'package:ecommerce_ui/Akun/AkunBottomNavBar.dart';
import 'package:ecommerce_ui/Akun/Akun_body.dart';
import 'package:ecommerce_ui/Akun/Akun_pic.dart';
import 'package:flutter/material.dart';



class AkunScreen extends StatelessWidget {
  static String routeName = "/Akun";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            //t
            height: 700,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: Column(children: [
              AkunBody(),
              Container(
                //decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(10),
                // ),
              ),
            ]
            ),
          ),
        ],
      ),
      bottomNavigationBar: AkunBottomNavBar(),
    );
  }
}

