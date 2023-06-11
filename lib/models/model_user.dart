import 'package:ecommerce_ui/SessionManager.dart';

class Users {
  int? idCustomer;
  String? namaCustomer;
  String? email;
  String? noTelpCustomer;
  String? alamat;

  Users({
    this.idCustomer,
    this.namaCustomer,
    this.email,
    this.noTelpCustomer,
    this.alamat,
  });

  Users.fromJson(Map<String, dynamic> json) {
    idCustomer = json['id_customer'];
    namaCustomer = json['nama_customer'];
    email = json['email'];
    noTelpCustomer = json['no_telp_customer'];
    alamat = json['alamat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.idCustomer;
    data['nama_customer'] = this.namaCustomer;
    data['email'] = this.email;
    data['no_telp_customer'] = this.noTelpCustomer;
    data['alamat'] = this.alamat;
    return data;
  }


  static Future<int?> getIdCustomer() async {
    Users? userData = await SessionManager.getUserData();
    return userData?.idCustomer;
  }

}
