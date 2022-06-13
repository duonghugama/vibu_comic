import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
// import 'package:image_picker_web/image_picker_web.dart';

class ThemChapTruyenScreen extends StatefulWidget {
  @override
  State<ThemChapTruyenScreen> createState() => _ThemChapTruyenScreenState();
}

class _ThemChapTruyenScreenState extends State<ThemChapTruyenScreen> {
  List<Uint8List> listImage = [];
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
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
                        child: Text("Thêm chương"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Flexible(
            child: Center(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: listImage.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == listImage.length) {
                    return Container(
                      height: 500,
                      width: 200,
                      color: Colors.grey,
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () async {
                          final picked = await FilePicker.platform.pickFiles(allowMultiple: true);
                          // final picked = await ImagePickerWeb.getMultiImagesAsBytes();
                          if (picked != null) {
                            setState(() {
                              listImage = picked.files.map((e) => e.bytes!).toList();
                            });
                          } else {
                            setState(() {
                              // pickedfile = null;
                            });
                          }
                        },
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Container(
                          height: 500,
                          width: 200,
                          color: Colors.grey,
                          child: Image.memory(
                            listImage[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
