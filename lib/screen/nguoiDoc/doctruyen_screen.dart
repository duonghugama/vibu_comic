import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vibu_comic/api/firebase_api.dart';
import 'package:vibu_comic/model/anhtruyen.dart';
import 'package:vibu_comic/model/firebase_file.dart';

class DocTruyenScreen extends StatefulWidget {
  final String idTruyen;
  final String idChap;
  DocTruyenScreen(this.idTruyen, this.idChap);

  @override
  State<DocTruyenScreen> createState() => _DocTruyenScreenState(idTruyen, idChap);
}

class _DocTruyenScreenState extends State<DocTruyenScreen> {
  final String idTruyen;
  final String idChap;
  List<AnhTruyen> listAnhTruyen = [];

  late Reference ref;

  _DocTruyenScreenState(this.idTruyen, this.idChap);

  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    // futureFiles = FirebaseStorage.instance.ref("/comicData/OnePunch-Man/Chapter 1/").listAll();
    futureFiles = FirebaseApi.listAll('/comicData/$idTruyen/$idChap/');
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
        body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  final files = snapshot.data!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // buildHeader(files.length),
                      // const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return Image.network(
                              file.url,
                              fit: BoxFit.fill,
                            );
                            // return buildFile(context, file);
                          },
                        ),
                      ),
                    ],
                  );
                }
            }
          },
        ),
        // ListView.builder(
        //   itemCount: 17,
        //   itemBuilder: (context, index) {
        //     if (index < 9) {
        //       return Image(
        //         fit: BoxFit.fill,
        //         image: AssetImage('assets/OnePunch-Man/Anh0${index + 1}.png'),
        //       );
        //     } else {
        //       return Image(
        //         fit: BoxFit.fill,
        //         image: AssetImage('assets/OnePunch-Man/Anh${index + 1}.png'),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
