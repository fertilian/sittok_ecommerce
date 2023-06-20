class GetNota {
  int? idDetilJual;
  int? idJual;
  int? idBarang;
  int? idKeranjang;
  int? jumlah;
  int? harga;
  int? qty;
  String? createdAt;
  String? updatedAt;
  int? totalFinal;
  int? total;
  String? alamat;
  String? nohp;
  String? buktiBayar;
  String? status;
  String? namaLengkap;
  int? idCustomer;
  String? merkBarang;
  int? jumlahBarang;
  String? deskripsi;
  String? gambar;
  int? idKategori;

  GetNota(
      {this.idDetilJual,
      this.idJual,
      this.idBarang,
      this.idKeranjang,
      this.jumlah,
      this.harga,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.totalFinal,
      this.total,
      this.alamat,
      this.nohp,
      this.buktiBayar,
      this.status,
      this.namaLengkap,
      this.idCustomer,
      this.merkBarang,
      this.jumlahBarang,
      this.deskripsi,
      this.gambar,
      this.idKategori});

  GetNota.fromJson(Map<String, dynamic> json) {
    idDetilJual = json['id_detil_jual'];
    idJual = json['id_jual'];
    idBarang = json['id_barang'];
    idKeranjang = json['id_keranjang'];
    jumlah = json['jumlah'];
    harga = json['harga'];
    qty = json['qty'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalFinal = json['total_final'];
    total = json['total'];
    alamat = json['alamat'];
    nohp = json['nohp'];
    buktiBayar = json['bukti_bayar'];
    status = json['status'];
    namaLengkap = json['nama_lengkap'];
    idCustomer = json['id_customer'];
    merkBarang = json['merk_barang'];
    jumlahBarang = json['jumlah_barang'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    idKategori = json['id_kategori'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_detil_jual'] = this.idDetilJual;
    data['id_jual'] = this.idJual;
    data['id_barang'] = this.idBarang;
    data['id_keranjang'] = this.idKeranjang;
    data['jumlah'] = this.jumlah;
    data['harga'] = this.harga;
    data['qty'] = this.qty;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_final'] = this.totalFinal;
    data['total'] = this.total;
    data['alamat'] = this.alamat;
    data['nohp'] = this.nohp;
    data['bukti_bayar'] = this.buktiBayar;
    data['status'] = this.status;
    data['nama_lengkap'] = this.namaLengkap;
    data['id_customer'] = this.idCustomer;
    data['merk_barang'] = this.merkBarang;
    data['jumlah_barang'] = this.jumlahBarang;
    data['deskripsi'] = this.deskripsi;
    data['gambar'] = this.gambar;
    data['id_kategori'] = this.idKategori;
    return data;
  }
}