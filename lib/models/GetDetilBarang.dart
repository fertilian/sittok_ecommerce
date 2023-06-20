class GetDetilBarang {
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

  GetDetilBarang(
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

  GetDetilBarang.fromJson(Map<String, dynamic> json) {
    idBarang = json['id_barang'];
    merkBarang = json['merk_barang'];
    jumlahBarang = json['jumlah_barang'];
    harga = json['harga'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    idKategori = json['id_kategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_barang'] = this.idBarang;
    data['merk_barang'] = this.merkBarang;
    data['jumlah_barang'] = this.jumlahBarang;
    data['harga'] = this.harga;
    data['deskripsi'] = this.deskripsi;
    data['gambar'] = this.gambar;
    data['id_kategori'] = this.idKategori;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_liked'] = this.isLiked;
    return data;
  }
}