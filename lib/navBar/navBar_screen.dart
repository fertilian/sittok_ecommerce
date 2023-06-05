import 'package:ecommerce_ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/navBar/navBar.dart';

class NavbarScreen extends StatefulWidget {

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text('Navigation'),
          backgroundColor: Colors.purple[200]),
        body: const Center(
          child: Text('Main Page',
          style: TextStyle(fontSize: 40.0),
          )
        )
      ),//scaffold
    );
  }
}

scaffold({required NavBar drawer, required AppBar appBar, required Center body}) {
}
