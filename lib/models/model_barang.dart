class Productse {
  int idBarang;
  String merkBarang;
  int jumlahBarang;
  int harga;
  String deskripsi;
  String gambar;
  int idKategori;
  DateTime createdAt;
  DateTime updatedAt;
  bool isAvailable;


  Productse({
    required this.idBarang,
    required this.merkBarang,
    required this.jumlahBarang,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
    required this.idKategori,
    required this.createdAt,
    required this.updatedAt,

    required this.isAvailable,
  });

  factory Productse.fromJson(Map<String, dynamic> json) {
    return Productse(
      idBarang: json['id_barang'],
      merkBarang: json['merk_barang'],
      jumlahBarang: json['jumlah_barang'],
      harga: json['harga'],
      deskripsi: json['deskripsi'],
      gambar: json['gambar'],
      idKategori: json['id_kategori'],
      isAvailable: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),

    );
  }
}
