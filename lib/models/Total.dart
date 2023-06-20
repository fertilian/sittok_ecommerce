class Total {
  int? jumlah;

  Total({this.jumlah});

  Total.fromJson(Map<String, dynamic> json) {
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah'] = this.jumlah;
    return data;
  }
}