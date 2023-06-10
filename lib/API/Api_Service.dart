import 'dart:convert';

import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class ServiceApiBarang {
  Future<List<Productse>> getData() async {
    try {
      final response = await http.post(Uri.parse(ApiConnect.barang));
      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        List<Productse> data = it.map((e) => Productse.fromJson(e)).toList();
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}



