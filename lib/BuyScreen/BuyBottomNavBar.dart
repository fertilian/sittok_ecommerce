import 'package:ecommerce_ui/API/Api_Service.dart';
import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/constants.dart';
import 'package:ecommerce_ui/models/Total.dart';
import 'package:ecommerce_ui/models/Triger.dart';
import 'package:ecommerce_ui/models/UpdateStatusKeranjang_model.dart';
import 'package:ecommerce_ui/models/add_transaksi.dart';
import 'package:ecommerce_ui/models/detil_transaksi.dart';
import 'package:ecommerce_ui/models/getdataKeranjang.dart';
import 'package:ecommerce_ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class BuyBottomNavBar extends StatefulWidget {
  @override
  _BuyBottomNavBarState createState() => _BuyBottomNavBarState();
}

class _BuyBottomNavBarState extends State<BuyBottomNavBar> {
  late Future<List<GetKeranjang>> listKeranjang;
  final TextEditingController alamat = TextEditingController();
  final TextEditingController nohp = TextEditingController();
  final TextEditingController nama_lengkap = TextEditingController();

  late AddTransaksi transaksi;
  late AdddetilTransaksi detjual;

  List<GetKeranjang> listViews = [];
  Total? total;
  Future<List<GetKeranjang>> fetchData() async {
    try {
      List<GetKeranjang> data = await ServiceApiKeranjang().getData();
      Total? total = await TotalService().getTotalJumlah();

      total = total; // Assign the fetched Total object to _total
      listViews = data;
      return data;
    } catch (error) {
      // Handle error jika terjadi kesalahan saat mengambil data dari API
      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> form = [];
  late String _selectedDate;
  late String _selectedTime;
  int totalHarga = 0; // Ganti dengan nilai total harga yang sesuai
  int totalBayar = 0;
  int sisaBayar = 0;
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _totalBayarController = TextEditingController();
  TextEditingController _sisaBayarController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _hargaController = TextEditingController();
  TextEditingController _lapanganController = TextEditingController();
  TextEditingController _tipeController = TextEditingController();
  TextEditingController _buktiBayarController = TextEditingController();

  String namaCust = '';

  @override
  void dispose() {
    _startTimeController.dispose();
    _endTimeController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  Future<void> fetchData2() async {
    try {
      Total? total = await TotalService().getTotalJumlah();

      setState(() {
        this.total = total;
      });
    } catch (error) {
      // Handle error jika terjadi kesalahan saat mengambil data dari API
      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedStartTime = selectedTime;
        _startTimeController.text = selectedTime.format(context);
        _calculateHarga();
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );

    if (selectedTime != null) {
      setState(() {
        _selectedEndTime = selectedTime;
        _endTimeController.text = selectedTime.format(context);
        _calculateHarga();
      });
    }
  }

  Future<void> _calculateHarga() {
    if (_selectedStartTime != null && _selectedEndTime != null) {
      final int minDifference =
          _selectedEndTime.minute - _selectedStartTime.minute;
      final int hourDifference =
          (_selectedEndTime.hour - _selectedStartTime.hour) * 60;
      final int totalMinutes = minDifference + hourDifference;

      final int harga = form[0]['harga'];
      final int hargaKotor = totalMinutes * harga;
      final double totalHarga = hargaKotor / 60;

      _hargaController.text = totalHarga
          .toStringAsFixed(2); // Convert to string with 2 decimal places
    }

    return Future<void>.value();
  }


  @override
  void initState() {
    super.initState();
    fetchData2();
    listKeranjang = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    List<GetKeranjang> products;

    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  total?.jumlah.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          child: Container(
                            height: 1000,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Text(
                                  "Isi Form Berikut :",
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  cursorColor: kPrimaryColor,
                                  controller: nama_lengkap,
                                  decoration: const InputDecoration(
                                    hintText: "Nama Lengkap",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: _dateController,
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Tanggal',
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: _startTimeController,
                                  readOnly: true,
                                  onTap: () => _selectStartTime(context),
                                  decoration: InputDecoration(
                                    labelText: 'Jam Awal',
                                    suffixIcon: Icon(Icons.access_time),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  controller: _endTimeController,
                                  readOnly: true,
                                  onTap: () => _selectEndTime(context),
                                  decoration: InputDecoration(
                                    labelText: 'Jam Akhir',
                                    suffixIcon: Icon(Icons.access_time),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  cursorColor: kPrimaryColor,
                                  controller: alamat,
                                  decoration: const InputDecoration(
                                    hintText: "Alamat",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.home),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  cursorColor: kPrimaryColor,
                                  controller: nohp,
                                  decoration: const InputDecoration(
                                    hintText: "Nomor Hp",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.phone),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    verifyjual();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Check Out",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                    });
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Check Out",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 3)),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        _dateController.text = _selectedDate.toString();
      });
    }
  }

  Future<void> pop(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      "Daftar Aset",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: const [
                        Text(
                          "Nama Aset",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Harga",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Jumlah",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Total",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<List<GetKeranjang>>(
                      future: listKeranjang,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Error fetching data'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Data not found'));
                        } else {
                          List<GetKeranjang> products = snapshot.data!;
                          return Column(
                              children: List.generate(
                                  products.length,
                                      (index) => Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 70,
                                            child: Text(
                                              products[index]
                                                  .merkBarang
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 60,
                                            child: Text(
                                              products[index].harga.toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 40,
                                            child: Text(
                                              products[index].qty.toString(),
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            products[index].jumlah.toString(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )));
                        }
                      },
                    ),
                    Row(children: [
                      Spacer(),
                      const Text(
                        "Total : ",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        total?.jumlah.toString() ?? '',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ]),
                    const SizedBox(
                      height: 15,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        _handleDetil(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  void verifyjual() {
    if (nama_lengkap.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Nama Harus Diisi",
        backgroundColor: Colors.red[300],
        fontSize: 12,
      );
    } else if (alamat.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Alamat Harus Diisi",
          backgroundColor: Colors.red[300],
          fontSize: 12);
    } else if (nohp.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Nomor Harus Diisi",
          backgroundColor: Colors.red[300],
          fontSize: 12);
    } else {
      _handleJual(context);
    }
  }

  late SessionManager _sessionManager;
  Future<void> _handleJual(BuildContext context) async {
    _sessionManager = SessionManager();

    SessionManager.getIdCustomer().then((idCustomer) {
      var idCustomerString = idCustomer?.toString() ?? '';

      try {
        http.post(Uri.parse(ApiConnect.jual), body: {
          "total": total?.jumlah.toString(),
          "total_final": total?.jumlah.toString(),
          "alamat": alamat.text.toString(),
          "nohp": nohp.text.toString(),
          "nama_lengkap": nama_lengkap.text.toString(),
          "idCust": idCustomerString,
          "bukti_bayar": "image/no_money.png",
        }).then((response) {
          if (response.statusCode == 200) {
            final jsonData = jsonDecode(response.body);
            final jual = AddTransaksi.fromJson(jsonData);
            if (response.statusCode == 200) {
              transaksi = jual;
              pop(context);
            } else {
              Fluttertoast.showToast(
                msg: "Gagal Melakukan Pembelian",
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 12,
              );
            }
          } else {
            Fluttertoast.showToast(
              msg: "Coba Beberapa Saat Lagi",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 12,
            );
          }
        });
      } catch (e) {
        // Handle error
        print('Error: $e');
      }
    });
  }

  Future<void> _handleDetil(BuildContext context) async {
    try {
      for (int index = 0; index < listViews.length; index++) {
        var response = await http.post(Uri.parse(ApiConnect.detiljual), body: {
          "id_jual": transaksi.idJual.toString(),
          "id_keranjang": listViews[index].idKeranjang.toString(),
          "jumlah": listViews[index].jumlah.toString(),
          "harga": listViews[index].harga.toString(),
          "qty": listViews[index].qty.toString(),
          "total_final": total!.jumlah.toString(),
          "idAset": listViews[index].idBarang.toString(),
        });

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final detjuals = AdddetilTransaksi.fromJson(jsonData);
          if (response.statusCode == 200) {
            _handlestatus(context);
            _handlebarang();
            setState(() {
              detjual = detjuals;
            });
          } else {
            Fluttertoast.showToast(
              msg: "Gagal Melakukan Pembelian",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 12,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "Coba Beberapa Saat Lagi",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<void> _handlestatus(BuildContext context) async {
    try {
      for (int index = 0; index < listViews.length; index++) {
        var response = await http.post(Uri.parse(ApiConnect.statusjual), body: {
          "id_keranjang": listViews[index].idKeranjang.toString(),
        });

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final detjuals = UpdateStatusKeranjang.fromJson(jsonData);
          if (response.statusCode == 200) {
            _handlebarang();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FragmentProduk(),
                ),
              );
              Fluttertoast.showToast(
                msg: "Ayo Belanja Lagi",
                backgroundColor: Color(0xFF4C53A5),
                textColor: Colors.white,
                fontSize: 12,
              );
            });
          } else {
            Fluttertoast.showToast(
              msg: "Gagal Melakukan Pembelian",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 12,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "Coba Beberapa Saat Lagi",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<void> _handlebarang() async {
    try {
      for (int index = 0; index < listViews.length; index++) {
        var response = await http.post(Uri.parse(ApiConnect.triger), body: {
          "idAset": listViews[index].idBarang.toString(),
          "qty": listViews[index].qty
        });

        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final detjuals = Triger.fromJson(jsonData);
          if (response.statusCode == 200) {
          } else {
            Fluttertoast.showToast(
              msg: "Gagal Melakukan Pembelian",
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 12,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "Coba Beberapa Saat Lagi",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
