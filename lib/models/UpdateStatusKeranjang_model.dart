class UpdateStatusKeranjang {
  int? idKeranjang;
  int? idCustomer;
  int? idBarang;
  int? qty;
  String? createdAt;
  String? updatedAt;
  String? status;

  UpdateStatusKeranjang(
      {this.idKeranjang,
      this.idCustomer,
      this.idBarang,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.status});

  UpdateStatusKeranjang.fromJson(Map<String, dynamic> json) {
    idKeranjang = json['id_keranjang'];
    idCustomer = json['id_customer'];
    idBarang = json['id_barang'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_keranjang'] = this.idKeranjang;
    data['id_customer'] = this.idCustomer;
    data['id_barang'] = this.idBarang;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}