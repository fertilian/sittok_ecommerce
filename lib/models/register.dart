class Register {
  bool? success;
  String? message;
  Data? data;

  Register({this.success, this.message, this.data});

  Register.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? idCustomer;
  String? namaCustomer;
  String? email;
  String? noTelpCustomer;
  String? alamat;

  Data(
      {this.idCustomer,
        this.namaCustomer,
        this.email,
        this.noTelpCustomer,
        this.alamat});

  Data.fromJson(Map<String, dynamic> json) {
    idCustomer = json['idCust'];
    namaCustomer = json['namaCust'];
    email = json['email_Cust'];
    noTelpCustomer = json['no_telp'];
    alamat = json['alamat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCust'] = this.idCustomer;
    data['namaCust'] = this.namaCustomer;
    data['email_Cust'] = this.email;
    data['no_telp'] = this.noTelpCustomer;
    data['alamat'] = this.alamat;
    return data;
  }
}