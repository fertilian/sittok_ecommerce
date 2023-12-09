class Productse {
  int? idBarang;
  String? merkBarang;
  int? jumlahBarang;
  int? harga;
  String? deskripsi;
  String? gambar;
  int? idKategori;
  String? createdAt;
  String? updatedAt;
  bool? isLiked;

  Productse(
      {this.idBarang,
        this.merkBarang,
        this.jumlahBarang,
        this.harga,
        this.deskripsi,
        this.gambar,
        this.idKategori,
        this.createdAt,
        this.updatedAt,
        this.isLiked});

  Productse.fromJson(Map<String, dynamic> json) {
    idBarang = json['idAset'];
    merkBarang = json['nama_aset'];
    jumlahBarang = json['jumlah_aset'];
    harga = json['harga'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    idKategori = json['idKategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAset'] = this.idBarang;
    data['nama_aset'] = this.merkBarang;
    data['jumlah_aset'] = this.jumlahBarang;
    data['harga'] = this.harga;
    data['deskripsi'] = this.deskripsi;
    data['gambar'] = this.gambar;
    data['idKategori'] = this.idKategori;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_liked'] = this.isLiked;
    return data;
  }
}