import 'package:ecommerce_ui/screens/splash_view.dart';
import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SITTOK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Montserrat',
              bodyColor: kSecondaryColor,
            ),
        iconTheme: const IconThemeData(
          color: kSecondaryColor,
        ),
      ),
      home: const SplashView(),
    );
  }
}
