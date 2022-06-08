import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:vibu_comic/model/truyen.dart';

class ThemTruyenScreen extends StatefulWidget {
  @override
  State<ThemTruyenScreen> createState() => _ThemTruyenScreenState();
}

class _ThemTruyenScreenState extends State<ThemTruyenScreen> {
  Reference ref = Firestore.instance.reference("/comicData");

  Stream<List<Truyen>> readComics() => FirebaseFirestore.instance
      .collection('comics')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => Truyen.fromJson(e.data())).toList());

  File image = File("");

  Stream<List<Truyen>> getComics() {
    return Firestore.instance
        .collection("comics")
        .stream
        .map((event) => event.map((e) => Truyen.fromJson(e.map)).toList());
  }

  Widget buildTruyen(Truyen truyen) => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () {
            print(truyen.idTruyen);
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(truyen.linkAnhTruyen, fit: BoxFit.fill),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black38,
                  gradient: LinearGradient(
                      colors: const [Colors.black87, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    truyen.tenTruyen,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

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
                        onPressed: () {},
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
                          child: image.path.isEmpty
                              ? Container(
                                  height: 500,
                                  width: 200,
                                  color: Colors.grey,
                                  child: IconButton(
                                    icon: Icon(Icons.add_a_photo),
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles();

                                      if (result != null) {
                                        setState(() {
                                          image = File(result.files.single.path!);
                                        });
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                  ),
                                )
                              : Stack(
                                  children: [
                                    Container(
                                        height: 500,
                                        width: 200,
                                        color: Colors.grey,
                                        child: Image.file(image, fit: BoxFit.fill)),
                                    Positioned(
                                      top: 0,
                                      right: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            image = File("");
                                          });
                                        },
                                        icon: Icon(Icons.highlight_remove, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
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
                                Flexible(
                                  child: TextFormField(
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
                            TextFormField(
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
                            TextFormField(
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
