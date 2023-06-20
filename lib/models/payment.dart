class Paymen {
  int? idPaymen;
  String? jenisPaymen;
  String? noPaymen;
  Null? createdAt;
  Null? updatedAt;
  String? icon;

  Paymen(
      {this.idPaymen,
      this.jenisPaymen,
      this.noPaymen,
      this.createdAt,
      this.updatedAt,
      this.icon});

  Paymen.fromJson(Map<String, dynamic> json) {
    idPaymen = json['id_paymen'];
    jenisPaymen = json['jenis_paymen'];
    noPaymen = json['no_paymen'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_paymen'] = this.idPaymen;
    data['jenis_paymen'] = this.jenisPaymen;
    data['no_paymen'] = this.noPaymen;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['icon'] = this.icon;
    return data;
  }
}