class AdddetilTransaksi {
  String? idJual;
  String? idKeranjang;
  String? jumlah;
  String? qty;
  String? harga;
  String? updatedAt;
  String? createdAt;
  int? id;

  AdddetilTransaksi(
      {this.idJual,
      this.idKeranjang,
      this.jumlah,
      this.qty,
      this.harga,
      this.updatedAt,
      this.createdAt,
      this.id});

  AdddetilTransaksi.fromJson(Map<String, dynamic> json) {
    idJual = json['id_jual'];
    idKeranjang = json['id_keranjang'];
    jumlah = json['jumlah'];
    qty = json['qty'];
    harga = json['harga'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jual'] = this.idJual;
    data['id_keranjang'] = this.idKeranjang;
    data['jumlah'] = this.jumlah;
    data['qty'] = this.qty;
    data['harga'] = this.harga;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}