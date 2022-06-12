import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vibu_comic/api/firebase_api.dart';
import 'package:vibu_comic/model/anhtruyen.dart';
import 'package:vibu_comic/model/firebase_file.dart';

class DocTruyenScreen2 extends StatefulWidget {
  final List linkAnh;
  DocTruyenScreen2(this.linkAnh);

  @override
  State<DocTruyenScreen2> createState() => _DocTruyenScreen2State(linkAnh);
}

class _DocTruyenScreen2State extends State<DocTruyenScreen2> {
  final List linkAnh;

  List<AnhTruyen> listAnhTruyen = [];

  late Reference ref;

  late Future<List<FirebaseFile>> futureFiles;

  _DocTruyenScreen2State(this.linkAnh);

  @override
  void initState() {
    super.initState();
    // futureFiles = FirebaseStorage.instance.ref("/comicData/OnePunch-Man/Chapter 1/").listAll();
    // futureFiles = FirebaseApi.listAll('/comicData/$idTruyen/$idChap/');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildHeader(int length) => ListTile(
        tileColor: Colors.blue,
        leading: Container(
          width: 52,
          height: 52,
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
        title: Text(
          '$length Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );
  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
        leading: ClipOval(
          child: Image.network(
            file.url,
            width: 52,
            height: 52,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          file.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      minScale: 1,
      maxScale: 5,
      child: Scaffold(
        body: ListView.builder(
          itemCount: linkAnh.length,
          itemBuilder: (context, index) {
            return Image.network(
              linkAnh[index].toString(),
              fit: BoxFit.fill,
            );
          },
        ),
        // body: FutureBuilder<List<FirebaseFile>>(
        //   future: futureFiles,
        //   builder: (context, snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //         return Center(child: CircularProgressIndicator());
        //       default:
        //         if (snapshot.hasError) {
        //           return Center(child: Text('Some error occurred!'));
        //         } else {
        //           final files = snapshot.data!;
        //           return Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Expanded(
        //                 child: ListView.builder(
        //                   itemCount: files.length,
        //                   itemBuilder: (context, index) {
        //                     final file = files[index];
        //                     return Image.network(
        //                       file.url,
        //                       fit: BoxFit.fill,
        //                     );
        //                   },
        //                 ),
        //               ),
        //             ],
        //           );
        //         }
        //     }
        //   },
        // ),
      ),
    );
  }
}
