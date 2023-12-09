class AddChart {
  String? idCustomer;
  String? idBarang;
  String? qty;
  String? updatedAt;
  String? createdAt;
  int? idKeranjang;
  bool success;
  late String message;

  AddChart({
    this.idCustomer,
    this.idBarang,
    this.qty,
    this.updatedAt,
    this.createdAt,
    this.idKeranjang,
    required this.success,
  }) : message = ''; // Initializing 'message' with an empty string

  AddChart.fromJson(Map<String, dynamic> json)
      : idCustomer = json['idCust'],
        idBarang = json['idAset'],
        qty = json['qty'],
        updatedAt = json['updated_at'],
        createdAt = json['created_at'],
        idKeranjang = json['id_keranjang'],
        success = json['success'] ?? false,
        message = json['message'] ?? '';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'idCust': idCustomer,
      'idAset': idBarang,
      'qty': qty,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id_keranjang': idKeranjang,
      'success': success,
      'message': message,
    };
    return data;
  }
}
