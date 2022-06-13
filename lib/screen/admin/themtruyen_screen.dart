import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vibu_comic/model/truyen.dart';

class ThemTruyenScreen extends StatefulWidget {
  @override
  State<ThemTruyenScreen> createState() => _ThemTruyenScreenState();
}

class _ThemTruyenScreenState extends State<ThemTruyenScreen> {
  File image = File("");
  Uint8List? imagePicked;
  // PlatformFile? pickedfile;
  // Reference ref = Firestore.instance.reference("/comicData");
  // late Uint8List imageDisplayWeb;

  Stream<List<Truyen>> readComics() => FirebaseFirestore.instance
      .collection('comics')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => Truyen.fromJson(e.data())).toList());
  var tenTruyenController = TextEditingController();
  var tenKhacController = TextEditingController();
  var giaTruyenController = TextEditingController();
  var tacGiaController = TextEditingController();
  var theLoaiController = TextEditingController();
  var moTaController = TextEditingController();
  Future createTruyen() async {
    final docTruyen = FirebaseFirestore.instance.collection("comics").doc();

    final path = 'comicData/${docTruyen.id}/AnhTruyen.jpg';
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putData(imagePicked!);
    String linkanhtruyen = ref.getDownloadURL().toString();
    final truyen = Truyen(
      linkAnhTruyen: linkanhtruyen,
      daHoanThanh: false,
      gia: int.tryParse(giaTruyenController.text) ?? 0,
      idTruyen: docTruyen.id,
      tenTruyen: tenTruyenController.text,
      tenKhac: tenKhacController.text,
      tacGia: tacGiaController.text,
      theLoai: theLoaiController.text.split(' '),
      moTa: moTaController.text,
    );
    final json = truyen.toJson();
    await docTruyen.set(json);
    // await ref.putFile(image);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // var screenHeight = MediaQuery.of(context).size.height;

    bool isWide = screenWidth >= 800;
    return Scaffold(
      body: Row(
        children: [
          if (isWide)
            SizedBox(
              width: 300,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back)),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/VibuComic.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          createTruyen();
                        },
                        child: Text("Thêm truyện"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        fit: FlexFit.loose,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 500,
                                width: 200,
                                color: Colors.grey,
                                child: IconButton(
                                  icon: Icon(Icons.add_a_photo),
                                  onPressed: () async {
                                    final picked = await FilePicker.platform.pickFiles();
                                    // final picked = await ImagePickerWeb.getImageAsBytes();
                                    if (picked != null) {
                                      setState(() {
                                        imagePicked = picked as Uint8List?;
                                      });
                                    } else {
                                      setState(() {
                                        // pickedfile = null;
                                      });
                                    }
                                  },
                                ),
                              ),
                              imagePicked != null
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: 500,
                                          width: 200,
                                          color: Colors.grey,
                                          child: !kIsWeb
                                              ? Image.file(image, fit: BoxFit.fill)
                                              : Image.memory(imagePicked!),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 10,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                imagePicked = null;
                                                image = File("");
                                              });
                                            },
                                            icon: Icon(Icons.highlight_remove, color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Spacer(),
                            Row(
                              children: [
                                Flexible(
                                  flex: 10,
                                  child: TextFormField(
                                    controller: tenTruyenController,
                                    decoration: InputDecoration(
                                      label: Text("Tên truyện"),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                Flexible(
                                  flex: 10,
                                  child: TextFormField(
                                    controller: tenKhacController,
                                    decoration: InputDecoration(
                                      label: Text("Tên khác"),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            TextFormField(
                              controller: tacGiaController,
                              decoration: InputDecoration(
                                label: Text("Tác giả"),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                            Spacer(),
                            TextFormField(
                              controller: theLoaiController,
                              decoration: InputDecoration(
                                label: Text("Thể loại"),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                            Spacer(),
                            TextFormField(
                              controller: giaTruyenController,
                              decoration: InputDecoration(
                                label: Text("Giá truyện/chap"),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // decoration: BoxDecoration(border: Border.all(width: 1)),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      maxLines: null,
                      controller: moTaController,
                      decoration: InputDecoration(
                        label: Text("Mô tả"),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
