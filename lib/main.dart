import 'package:flutter/material.dart';

import 'screens/home_screen/home_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce UI',
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
      home: const HomeScreen(),
    );
  }
}
