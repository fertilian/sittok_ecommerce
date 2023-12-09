import 'dart:io';

import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/Akun/AkunMenu.dart';
import 'package:ecommerce_ui/Akun/Akun_screen.dart';
import 'package:ecommerce_ui/Help/HelpCenter.dart';
import 'package:ecommerce_ui/Screen/Login/login_screen.dart';
import 'package:ecommerce_ui/SessionManager.dart';
import 'package:ecommerce_ui/models/model_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AkunPic extends StatefulWidget {
  AkunPic({
    Key? key,
  }) : super(key: key);
  @override
  _AkunPicState createState() => _AkunPicState();
}

class _AkunPicState extends State<AkunPic> {
  Users? dataimage;

  Future<Users> fetchData() async {
    try {
      Users? data = await ServiceApiProfil().getData();
      setState(() {
        dataimage = data;
      });
      return data;
    } catch (error) {

      print('Error fetching data: $error');
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = "http://192.168.6.51:8000/storage/" +
        dataimage!.profil.toString();
    return Column(children: [
      const SizedBox(
        height: 40,
      ),
      SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              child: imageUrl != null
                  ? null
                  : CircularProgressIndicator(), // Menampilkan CircularProgressIndicator jika imageUrl masih kosong
            ),
            Positioned(
              right: -16,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white),
                    ),
                    primary: Colors.white,
                    backgroundColor: Color(0xFFF5F6F9),
                  ),
                  onPressed: () {
                    _potoBottomSheet();
                  },
                  child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 20),
      AkunMenu(
        text: "Help Center",
        icon: "assets/icons/question.png",
        press: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HelpCenter()),
          );
        },
      ),
      AkunMenu(
        text: "Log Out",
        icon: "assets/icons/logout.png",
        press: () {
          SessionManager.clearSession();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
      ),
    ]);
  }

  File? image;
  Future<void> getImageGalerry() async {
    var galleryPermission = Permission.storage;

    if (galleryPermission.status == PermissionStatus.denied) {
      galleryPermission.request();
      if (galleryPermission.status == PermissionStatus.permanentlyDenied) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(""),
            )
          ]),
        );
      }
    }

    final ImagePicker picker = ImagePicker();
    final imagePicked = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      image = File(imagePicked.path);

      _handlephoto();
      fetchData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AkunScreen()),
      );
      setState(() {});
    }
  }

  Future<void> getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    final imagePicked = await picker.pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      image = File(imagePicked.path);
      _handlephoto();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AkunScreen()),
      );
      fetchData();
      setState(() {});
    }
  }

  Future _potoBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.pop(
                          context); // Menutup modal bottom sheet sebelum memilih gambar dari kamera
                      await getImageCamera();
                    },
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xFF2A2A72).withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    title: const Text("Unggah dari Camera",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF454444),
                        )),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.pop(
                          context); // Menutup modal bottom sheet sebelum memilih gambar dari galeri
                      await getImageGalerry();
                    },
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color(0xFF2A2A72).withOpacity(0.1),
                      ),
                      child: const Icon(
                        Icons.image,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                    title: const Text("Unggah dari Galeri",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF454444),
                        )),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.shade200,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  late SessionManager _sessionManager;
  Future<void> _handlephoto() async {
    _sessionManager = SessionManager();

    SessionManager.getIdCustomer().then((idCustomer) async {
      var idCustomerString = idCustomer?.toString() ?? '';

      if (image == null) {
        Fluttertoast.showToast(
          msg: "Pilih gambar terlebih dahulu",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
        return;
      }

      var request =
      http.MultipartRequest('POST', Uri.parse(ApiConnect.updateprofil));
      request.fields['id_customer'] = idCustomerString;
      request.files
          .add(await http.MultipartFile.fromPath("profil", image!.path));

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          // Gambar berhasil diunggah
          print("Image Uploaded");

          Fluttertoast.showToast(
            msg: "Berhasil",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 12,
          );
        } else {
          // Gagal mengunggah gambar
          print("Image Not Uploaded");

          Fluttertoast.showToast(
            msg: "Gagal Mengunggah Gambar",
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      } catch (error) {
        // Terjadi kesalahan saat mengunggah gambar
        print("Error: $error");

        Fluttertoast.showToast(
          msg: "Terjadi Kesalahan",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    });
  }
}

class ServiceApiProfil {
  late SessionManager _sessionManager;

  Future<Users> getData() async {
    _sessionManager = SessionManager();
    try {
      var idCustomer = await SessionManager.getIdCustomer();
      var idCustomerString = idCustomer?.toString() ?? '';
      final response = await http.post(Uri.parse(ApiConnect.profil), body: {
        "id_customer": idCustomerString,
      });
      if (response.statusCode == 200) {
        print(response.body);

        dynamic jsonData = jsonDecode(response.body);
        Users data = Users.fromJson(jsonData);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}
