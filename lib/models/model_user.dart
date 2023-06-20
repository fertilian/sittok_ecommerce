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
    idCustomer = json['id_customer'];
    namaCustomer = json['nama_customer'];
    email = json['email'];
    noTelpCustomer = json['no_telp_customer'];
    alamat = json['alamat'];
    profil = json['profil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.idCustomer;
    data['nama_customer'] = this.namaCustomer;
    data['email'] = this.email;
    data['no_telp_customer'] = this.noTelpCustomer;
    data['alamat'] = this.alamat;
    data['profil'] = this.profil;
    return data;
  }
}