class Users {
  int? idCustomer;
  String? namaCustomer;
  String? email;
  String? noTelpCustomer;
  String? alamat;
  String? profil;

  Users(
      {this.idCustomer,
        this.namaCustomer,
        this.email,
        this.noTelpCustomer,
        this.alamat,
        this.profil});

  Users.fromJson(Map<String, dynamic> json) {
    idCustomer = json['idCust'];
    namaCustomer = json['namaCust'];
    email = json['email_Cust'];
    noTelpCustomer = json['no_telp'];
    alamat = json['alamat'];
    profil = json['gambar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCust'] = this.idCustomer;
    data['namaCust'] = this.namaCustomer;
    data['email_Cust'] = this.email;
    data['no_telp'] = this.noTelpCustomer;
    data['alamat'] = this.alamat;
    data['gambar'] = this.profil;
    return data;
  }
}