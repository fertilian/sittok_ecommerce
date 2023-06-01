import 'dart:async';

import 'package:ecommerce_ui/screens/Login_View.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return const Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Text(
          'Logo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
