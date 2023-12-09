import 'dart:io';
import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/models/GetTransaksi_model.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_ui/constants.dart';
import 'package:ecommerce_ui/models/getDataNota.dart';
import 'package:ecommerce_ui/screens/home_screen/components/coba.dart';
import 'package:ecommerce_ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotaScreen extends StatefulWidget {
  final List<GetNota> notaData;
 const NotaScreen({Key? key, required this.notaData}) : super(key: key);

  @override
  _NotaScreenState createState() => _NotaScreenState();
}

class _NotaScreenState extends State<NotaScreen> {

   late Future<List<GetNota>> listNota;


   List<GetNota> listGetDetail = [];
late List<GetTransaksi> data;

Future<List<GetNota>> fetchData(int index) async {
  try {
    String idJual = widget.notaData[index].idJual.toString();
    List<GetNota> data = await ServiceApiNota(idJual).getData();
    listGetDetail = data;
    return data;
  } catch (error) {
    // Tangani kesalahan jika terjadi kesalahan saat mengambil data dari API
    print('Error fetching data: $error');
    throw Exception('Gagal memuat data');
  }
}




@override
void initState() {
  super.initState();
  listNota = fetchData(0); // Pass the desired index value here
}

  @override
  Widget build(BuildContext context) {
    int index;
    return Scaffold(
     
      body:Scaffold(
        
    body: Padding(
      padding:const EdgeInsets.only(top: 20, right: 20, left: 20),
      child :
    
    Column(
      
  children: [
 Row(
      children :[
      IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.chevronLeft,
            ),
          ),
          const Spacer()
          ]),
    Row(
      children :[

        Image.asset(
    'assets/images/salamberdiri.png',
    width: 44,  // Sesuaikan ukuran gambar
    height: 44,
  ),
  const Spacer(),
      const  Text(
                 "Daftar Aset",
                  style:  TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                 const Spacer(),
      ]),
      const SizedBox(height: 20,),
      Row(children: [
       
        Text(
                 "No Transaksi : "+widget.notaData[0].idJual.toString(),
                  style:  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey,
                  ),
                ),
                 const Spacer(),
      ],),
      Row(children: [
        const Spacer(),
        Text(
                 widget.notaData[0].createdAt!.substring(0,10),
                  style:  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                   color: Colors.blueGrey,
                  ),
                ),
      ],),
        Row(children: [
        Column(children : [
        Text(
                  widget.notaData[0].namaLengkap.toString(),
                  style:  const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                 Text(
                  widget.notaData[0].alamat.toString(),
                  style:  const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey,
                  ),
                ),
                 Text(
                  widget.notaData[0].nohp.toString(),
                  style:  const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueGrey
                  ),
                ),
                

                
                ])
      ],),
      Expanded(
              child: 
      FutureBuilder<List<GetNota>>(
                future: listNota,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Belum Ada Aset'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Belum Ada Aset'));
                  } else {
                    List<GetNota> products = snapshot.data!;

                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child :
                           Container(
                                       padding: const EdgeInsets.all(10),
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: kPrimaryColor.withOpacity(0.2),
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(5),
                              child :
                            
                            Column(children: [
            Row(children: [
                 const Spacer(),
              Text("Harga: " +
           listGetDetail[index].harga.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey,
            ),
          ),
       
            ],),
            const Spacer(),
            Row(children : [

 Image.network(
   "http://192.168.6.51:8000/storage/" + listGetDetail[index].gambar!.toString(),
      height: 80,
      width: 80,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        // Tampilkan widget alternatif jika terjadi kesalahan saat memuat gambar
        return const Icon(
          Icons.error,
          size: 92,
        );
      },
    ),
const SizedBox(width: 10,),
              Column(
                
                children:[
            Text(
           listGetDetail[index].merkBarang.toString() ,
            style:const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
             textAlign: TextAlign.start,
          ),
          Container(
            width: 150,
            child :
          Text(
           listGetDetail[index].deskripsi.toString() ,
           maxLines: 4,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
            )]),
          const Spacer()
          ]),
          const Spacer(),

          Row(children: [
            const Spacer(),

            Column(children:[

         Text(
          "Jumlah : " + listGetDetail[index].qty.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          Text(
          "Total : " + listGetDetail[index].jumlah.toString() ,
            style:const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
             textAlign: TextAlign.start,
          ),
          
          ],)
          ],)
      ])),

    )));});}})),

        Row(children: [
        const Spacer(),
        Text(
               "Jumlah Bayar : " + widget.notaData[0].totalFinal.toString(),
                  style:  const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.normal,
                   color: Colors.black,
                  ),
                ),
      ],),

Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: kSecondaryColor
      ),
      child: InkWell(
        onTap: () {
      checkstatus();
        },
        child:  Center(
          child: Text(
           widget.notaData[0].status.toString() ,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
               color: kBackgroundColor,
            ),
          ),
        ),
      ),
    ),
    const SizedBox(height: 10,)
  ],
),
  )
    ));
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

       _showImageDialog(image);
       update();

  }
}

Future<void> getImageCamera() async {
  final ImagePicker picker = ImagePicker();
  final imagePicked = await picker.pickImage(source: ImageSource.camera);
  if (imagePicked != null) {
    image = File(imagePicked.path);
setState(() {
 _showImageDialog(image);
});
     
   
 
  }
}
void checkstatus(){
  if(widget.notaData[0].status == 'Belum Bayar'){
    _potoBottomSheet();
  }else if(widget.notaData[0].status == 'Proses'){
updateKlaim();
  }else{
_showImageDialogNot();
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
  Navigator.pop(context); // Menutup modal bottom sheet sebelum memilih gambar dari kamera
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
  Navigator.pop(context); // Menutup modal bottom sheet sebelum memilih gambar dari galeri
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
                        style:  TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF454444),
                     ) ),
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
  
  late File gaga;

Future<void> _showImageDialog(File? image) async {
 return  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
   
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            
  Image.file(
    image!,
    width: 200,
    height: 200,
    fit: BoxFit.cover,
  ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
      height: 34,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: Color(0xFF4C53A5)
      ),
      child: InkWell(
        onTap: () {
       Navigator.pop(context);
        },
        child: const Center(
          child: Text(
           "Cancel",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
               color: kBackgroundColor,
            ),
          ),
        ),
      ),
    ),
               Container(
      height: 34,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: Color(0xFF4C53A5)
      ),
      child: InkWell(
        onTap: () {
      update();
        },
        child: const Center(
          child: Text(
           "Kirim",
            style:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
               color: kBackgroundColor,
            ),
          ),
        ),
      ),
    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _showImageDialogNot() async {
  String imageUrl = 'http://192.168.6.51:8000/storage/' + widget.notaData[0].buktiBayar.toString();
 return  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(10),
   
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            
Image.network(
              imageUrl,
              height: 125,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 128,
                  color: Colors.grey,
                );
              },
            ),

              const SizedBox(height: 20),
                  Container(
      height: 34,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color: kSecondaryColor
      ),
      child: InkWell(
        onTap: () {
       Navigator.pop(context);
        },
        child: const Center(
          child: Text(
           "Oke",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
               color: kBackgroundColor,
            ),
          ),
        ),
      ),
    ),
 
   
             
            ],
          ),
        ),
      );
    },
  );
}
Future<void> update() async {
  if (image == null) {
   
    Fluttertoast.showToast(
      msg: "Pilih gambar terlebih dahulu",
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 12,
    );
    return;
  }

  var request = http.MultipartRequest('POST', Uri.parse(ApiConnect.bayar));
  request.fields['id_jual'] = widget.notaData[0].idJual.toString();
  request.files.add(await http.MultipartFile.fromPath("bukti_bayar", image!.path));

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
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
    } else {
      // Gagal mengunggah gambar
      print("Image Not Uploaded");
      print(widget.notaData[0].idJual);

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
}

Future<void> updateKlaim() async {
  if (image == null) {


  var request = http.MultipartRequest('POST', Uri.parse(ApiConnect.updateKlaim));
  request.fields['id_jual'] = widget.notaData[0].idJual.toString();

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
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
    } else {
      // Gagal mengunggah gambar
      print("Image Not Uploaded");
      print(widget.notaData[0].idJual);

      Fluttertoast.showToast(
        msg: "Coba Beberapa saat Lagi",
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

}}}