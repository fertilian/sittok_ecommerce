class AddTransaksi {
  String? total;
  String? totalFinal;
  String? alamat;
  String? nohp;
  String? namaLengkap;
  String? idCustomer;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? idJual;

  AddTransaksi(
      {this.total,
      this.totalFinal,
      this.alamat,
      this.nohp,
      this.namaLengkap,
      this.idCustomer,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.idJual});

  AddTransaksi.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalFinal = json['total_final'];
    alamat = json['alamat'];
    nohp = json['nohp'];
    namaLengkap = json['nama_lengkap'];
    idCustomer = json['idCust'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    idJual = json['id_jual'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_final'] = this.totalFinal;
    data['alamat'] = this.alamat;
    data['nohp'] = this.nohp;
    data['nama_lengkap'] = this.namaLengkap;
    data['idCust'] = this.idCustomer;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id_jual'] = this.idJual;
    return data;
  }
}