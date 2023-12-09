class Kategori {
  int? idKategori;
  String? namaKategori;
  String? createdAt;
  String? updatedAt;

  Kategori(
      {this.idKategori, this.namaKategori, this.createdAt, this.updatedAt});

  Kategori.fromJson(Map<String, dynamic> json) {
    idKategori = json['idKategori'];
    namaKategori = json['kategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idKategori'] = this.idKategori;
    data['kategori'] = this.namaKategori;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}