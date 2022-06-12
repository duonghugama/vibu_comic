import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vibu_comic/model/truyen.dart';
import 'package:vibu_comic/screen/admin/quanlytruyen_screen.dart';
import 'package:vibu_comic/screen/admin/themtruyen_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/truyen_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  Stream<List<Truyen>> readComics() => FirebaseFirestore.instance
      .collection('comics')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => Truyen.fromJson(e.data())).toList());

  // var comicsCollection = Firestore.instance.collection("comics").stream;
  // // Stre<List<DocumentSnapshot>> getComics() async {
  // //   List<DocumentSnapshot> comics = await comicsCollection.orderBy('id').get().then((value) => value.map((e) => Truyen.fromJson()));
  // //   return comics;
  // // }

  // Stream<List<Truyen>> getComics() {
  //   return Firestore.instance
  //       .collection("comics")
  //       .stream
  //       .map((event) => event.map((e) => Truyen.fromJson(e.map)).toList());
  // }

  Widget buildTruyen(Truyen truyen) => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () {
            print(truyen.idTruyen);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuanLyTruyenScreen(idTruyen: truyen.idTruyen),
              ),
            );
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
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ThemTruyenScreen(),
            ),
          );
        },
      ),
      body: Row(
        children: [
          if (isWide)
            SizedBox(
              width: 300,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/VibuComic.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            flex: 8,
            child: StreamBuilder<List<Truyen>>(
                stream: readComics(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Có lỗi xảy ra!! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final truyens = snapshot.data!;
                    return Center(
                      child: GridView(
                        padding: EdgeInsets.all(20),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (screenWidth / 250).round() == 0 ? 1 : (screenWidth / 250).round(),
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        children: truyens.map(buildTruyen).toList(),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
