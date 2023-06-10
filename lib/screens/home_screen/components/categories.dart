import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_ui/constants.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  Widget categoryItem(String text, {bool isFocused = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isFocused ? kSecondaryColor : kPrimaryColor.withOpacity(0.2),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isFocused ? kBackgroundColor : kSecondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    final categories = ['All', 'Laptop', 'Ram', 'Monitor', 'Keyboard', 'Charger'];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: categories.length,
        itemBuilder: (_, index) => categoryItem(
          categories[index],
          isFocused: index == 0,
        ),
      ),
    );
  }
}
