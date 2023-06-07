import 'package:ecommerce_ui/models/product.dart';
import 'package:flutter/material.dart' show IconData;

class ProductCategory {
  ProductCategory type;
  bool isSelected;
  IconData icon;

  ProductCategory(this.type, this.isSelected, this.icon);
}
