class GetTransaksi {
  int? idJual;
  int? total;
  int? totalFinal;
  String? alamat;
  String? nohp;
  String? buktiBayar;
  String? status;
  String? namaLengkap;
  String? createdAt;
  String? updatedAt;
  int? idCustomer;

  GetTransaksi(
      {this.idJual,
      this.total,
      this.totalFinal,
      this.alamat,
      this.nohp,
      this.buktiBayar,
      this.status,
      this.namaLengkap,
      this.createdAt,
      this.updatedAt,
      this.idCustomer});

  GetTransaksi.fromJson(Map<String, dynamic> json) {
    idJual = json['id_jual'];
    total = json['total'];
    totalFinal = json['total_final'];
    alamat = json['alamat'];
    nohp = json['nohp'];
    buktiBayar = json['bukti_bayar'];
    status = json['status'];
    namaLengkap = json['nama_lengkap'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idCustomer = json['idCust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jual'] = this.idJual;
    data['total'] = this.total;
    data['total_final'] = this.totalFinal;
    data['alamat'] = this.alamat;
    data['nohp'] = this.nohp;
    data['bukti_bayar'] = this.buktiBayar;
    data['status'] = this.status;
    data['nama_lengkap'] = this.namaLengkap;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['idCust'] = this.idCustomer;
    return data;
  }
}