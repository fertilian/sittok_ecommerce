

import 'package:ecommerce_ui/Help/HelpCenter.dart';
import 'package:ecommerce_ui/Screen/Login/login_screen.dart';
import 'package:flutter/material.dart';

import 'AkunMenu.dart';
import 'Akun_pic.dart';

class AkunBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          AkunPic(),
          SizedBox(height: 20),
          AkunMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpCenter()),
              );
            },
          ),

          AkunMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
