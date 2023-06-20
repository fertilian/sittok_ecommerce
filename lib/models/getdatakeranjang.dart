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
    idCustomer = json['id_customer'];
    idBarang = json['id_barang'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    harga = json['harga'];
    gambar = json['gambar'];
    merkBarang = json['merk_barang'];
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_keranjang'] = this.idKeranjang;
    data['id_customer'] = this.idCustomer;
    data['id_barang'] = this.idBarang;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['harga'] = this.harga;
    data['gambar'] = this.gambar;
    data['merk_barang'] = this.merkBarang;
    data['jumlah'] = this.jumlah;
    return data;
  }
}