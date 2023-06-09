import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('cobaaa'),
            accountEmail: const Text('cobaaa@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('images/sittok.png')
              ),
            ),
          decoration: BoxDecoration(
              color: Colors.purple,
          ),)
        ],
      ),
    );
  }
}


