
class AddChart {
  String? idCustomer;
  String? idBarang;
  String? qty;
  String? updatedAt;
  String? createdAt;
  int? idKeranjang;

  AddChart(
      {this.idCustomer,
        this.idBarang,
        this.qty,
        this.updatedAt,
        this.createdAt,
        this.idKeranjang});

  AddChart.fromJson(Map<String, dynamic> json) {
    idCustomer = json['id_customer'];
    idBarang = json['id_barang'];
    qty = json['qty'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    idKeranjang = json['id_keranjang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.idCustomer;
    data['id_barang'] = this.idBarang;
    data['qty'] = this.qty;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id_keranjang'] = this.idKeranjang;
    return data;
  }
}