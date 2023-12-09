class GetKeranjang {
  int? idKeranjang;
  int? idCustomer;
  int? idBarang;
  int? qty;
  String? createdAt;
  String? updatedAt;
  int? harga;
  String? gambar;
  String? merkBarang;
  int? jumlah;

  GetKeranjang(
      {this.idKeranjang,
        this.idCustomer,
        this.idBarang,
        this.qty,
        this.createdAt,
        this.updatedAt,
        this.harga,
        this.gambar,
        this.merkBarang,
        this.jumlah});

  GetKeranjang.fromJson(Map<String, dynamic> json) {
    idKeranjang = json['id_keranjang'];
    idCustomer = json['idCust'];
    idBarang = json['idAset'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    harga = json['harga'];
    gambar = json['gambar'];
    merkBarang = json['nama_aset'];
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_keranjang'] = this.idKeranjang;
    data['idCust'] = this.idCustomer;
    data['idAset'] = this.idBarang;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['harga'] = this.harga;
    data['gambar'] = this.gambar;
    data['nama_aset'] = this.merkBarang;
    data['jumlah'] = this.jumlah;
    return data;
  }
}