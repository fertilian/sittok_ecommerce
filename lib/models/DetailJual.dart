class DetileJual {
  Jual? jual;
  List<DetilJual>? detilJual;
  List<Keranjang>? keranjang;
  List<Barang>? barang;

  DetileJual({this.jual, this.detilJual, this.keranjang, this.barang});

  DetileJual.fromJson(Map<String, dynamic> json) {
    jual = json['jual'] != null ? new Jual.fromJson(json['jual']) : null;
    if (json['detil_jual'] != null) {
      detilJual = <DetilJual>[];
      json['detil_jual'].forEach((v) {
        detilJual!.add(new DetilJual.fromJson(v));
      });
    }
    if (json['keranjang'] != null) {
      keranjang = <Keranjang>[];
      json['keranjang'].forEach((v) {
        keranjang!.add(new Keranjang.fromJson(v));
      });
    }
    if (json['aset'] != null) {
      barang = <Barang>[];
      json['aset'].forEach((v) {
        barang!.add(new Barang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jual != null) {
      data['jual'] = this.jual!.toJson();
    }
    if (this.detilJual != null) {
      data['detil_jual'] = this.detilJual!.map((v) => v.toJson()).toList();
    }
    if (this.keranjang != null) {
      data['keranjang'] = this.keranjang!.map((v) => v.toJson()).toList();
    }
    if (this.barang != null) {
      data['aset'] = this.barang!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jual {
  int? idJual;
  int? total;
  int? totalFinal;
  String? alamat;
  String? nohp;
  Null? buktiBayar;
  String? status;
  String? namaLengkap;
  String? createdAt;
  String? updatedAt;
  int? idCustomer;

  Jual(
      {this.idJual,
      this.total,
      this.totalFinal,
      this.alamat,
      this.nohp,
      this.buktiBayar,
      this.status,
      this.namaLengkap,
      this.createdAt,
      this.updatedAt,
      this.idCustomer});

  Jual.fromJson(Map<String, dynamic> json) {
    idJual = json['id_jual'];
    total = json['total'];
    totalFinal = json['total_final'];
    alamat = json['alamat'];
    nohp = json['nohp'];
    buktiBayar = json['bukti_bayar'];
    status = json['status'];
    namaLengkap = json['nama_lengkap'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idCustomer = json['idCust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_jual'] = this.idJual;
    data['total'] = this.total;
    data['total_final'] = this.totalFinal;
    data['alamat'] = this.alamat;
    data['nohp'] = this.nohp;
    data['bukti_bayar'] = this.buktiBayar;
    data['status'] = this.status;
    data['nama_lengkap'] = this.namaLengkap;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['idCust'] = this.idCustomer;
    return data;
  }
}

class DetilJual {
  int? idDetilJual;
  int? idJual;
  int? idKeranjang;
  int? jumlah;
  String? createdAt;
  String? updatedAt;
  int? qty;
  int? harga;

  DetilJual(
      {this.idDetilJual,
      this.idJual,
      this.idKeranjang,
      this.jumlah,
      this.createdAt,
      this.updatedAt,
      this.qty,
      this.harga});

  DetilJual.fromJson(Map<String, dynamic> json) {
    idDetilJual = json['id_detil_jual'];
    idJual = json['id_jual'];
    idKeranjang = json['id_keranjang'];
    jumlah = json['jumlah'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    qty = json['qty'];
    harga = json['harga'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_detil_jual'] = this.idDetilJual;
    data['id_jual'] = this.idJual;
    data['id_keranjang'] = this.idKeranjang;
    data['jumlah'] = this.jumlah;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['qty'] = this.qty;
    data['harga'] = this.harga;
    return data;
  }
}

class Keranjang {
  int? idKeranjang;
  int? idCustomer;
  int? idBarang;
  int? qty;
  String? createdAt;
  String? updatedAt;
  String? status;

  Keranjang(
      {this.idKeranjang,
      this.idCustomer,
      this.idBarang,
      this.qty,
      this.createdAt,
      this.updatedAt,
      this.status});

  Keranjang.fromJson(Map<String, dynamic> json) {
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

class Barang {
  int? idBarang;
  String? merkBarang;
  int? jumlahBarang;
  int? harga;
  String? deskripsi;
  String? gambar;
  int? idKategori;
  String? createdAt;
  String? updatedAt;

  Barang(
      {this.idBarang,
      this.merkBarang,
      this.jumlahBarang,
      this.harga,
      this.deskripsi,
      this.gambar,
      this.idKategori,
      this.createdAt,
      this.updatedAt});

  Barang.fromJson(Map<String, dynamic> json) {
    idBarang = json['idAset'];
    merkBarang = json['nama_aset'];
    jumlahBarang = json['jumlah_aset'];
    harga = json['harga'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    idKategori = json['idKategori'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}