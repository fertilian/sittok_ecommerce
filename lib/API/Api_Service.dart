import 'dart:convert';

import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/GetKategori.dart';
import 'package:ecommerce_ui/models/GetTransaksi_model.dart';
import 'package:ecommerce_ui/models/Total.dart';
import 'package:ecommerce_ui/models/getdataKeranjang.dart';
import 'package:ecommerce_ui/models/model_barang.dart';
import 'package:ecommerce_ui/models/model_favorit.dart';
import 'package:ecommerce_ui/models/payment.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class ServiceApiAset {
  late SessionManager _sessionManager;

  Future<List<Productse>> getData() async {
    _sessionManager = SessionManager();
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.aset), body: {
        'idCust': idCustomerString
      });
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Productse> data =
        jsonData.map((e) => Productse.fromJson(e)).toList();
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


class ServiceApiFavorit {
  late SessionManager _sessionManager;

  Future<List<GetDataFav>> getData() async {
    _sessionManager = SessionManager();
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.favorit), body: {
        'idCust': idCustomerString
      });
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<GetDataFav> data =
        jsonData.map((e) => GetDataFav.fromJson(e)).toList();
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
class TotalService{
  late SessionManager _sessionManager;

  Future<Total> getTotalJumlah() async {
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.total), body: {
        'idCust': idCustomerString
      });
      if (response.statusCode == 200) {
        print(response.body);
        final jsonData = jsonDecode(response.body);
        final total = Total.fromJson(jsonData);
        return total;
      } else {
        throw Exception('Failed to load total jumlah');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load total jumlah');
    }
  }

}

class ServiceApiKeranjang {
  late SessionManager _sessionManager;

  Future<List<GetKeranjang>> getData() async {
    _sessionManager = SessionManager();
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.keranjang), body: {
        'idCust': idCustomerString
      });
      if (response.statusCode == 200) {
        print(response.body);
        print(idCustomer);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<GetKeranjang> data =
        jsonData.map((e) => GetKeranjang.fromJson(e)).toList();
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
class ServiceApiPaymen {
  Future<List<Paymen>> getData() async {

    try {

      final response = await http.post(Uri.parse(ApiConnect.paymen));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Paymen> data =
        jsonData.map((e) => Paymen.fromJson(e)).toList();
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

class ServiceApiKategori {
  Future<List<Kategori>> getData() async {

    try {

      final response = await http.post(Uri.parse(ApiConnect.kategori));
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<Kategori> data =
        jsonData.map((e) => Kategori.fromJson(e)).toList();
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

class ServiceApiGetTrans {
  late SessionManager _sessionManager;

  Future<List<GetTransaksi>> getData() async {
    _sessionManager = SessionManager();
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.getjual), body: {
        'idCust': idCustomerString
      });
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonData = jsonDecode(response.body);
        List<GetTransaksi> data =
        jsonData.map((e) => GetTransaksi.fromJson(e)).toList();
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