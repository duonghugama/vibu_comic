import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibu_comic/model/truyen.dart';
import 'package:vibu_comic/model/user.dart';
import 'package:vibu_comic/screen/login_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/truyen_screen.dart';

class UserHomeScrene extends StatefulWidget {
  static UserModel userModel = UserModel(id: "", coin: 0, pass: "", email: "", username: "", isAdmin: false);
  @override
  State<UserHomeScrene> createState() => _UserHomeScreneState();
}

class _UserHomeScreneState extends State<UserHomeScrene> {
  Stream<List<Truyen>> readComics() => FirebaseFirestore.instance
      .collection('comics')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => Truyen.fromJson(e.data())).toList());

  Future<UserModel> getUser(String user) {
    // QuerySnapshot snapshot = await
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      UserHomeScrene.userModel = UserModel.fromJson(value.docs.first.data());

      return UserModel.fromJson(value.docs.first.data());
    });
    // return UserModel.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }

  Stream<UserModel> getUserstream() {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map((event) {
      UserHomeScrene.userModel = UserModel.fromJson(event.docs.first.data());

      return UserModel.fromJson(
        event.docs.first.data(),
      );
    });
  }

  Widget buildTruyen(Truyen truyen) => ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GestureDetector(
          onTap: () {
            print(truyen.idTruyen);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TruyenScreen(idTruyen: truyen.idTruyen),
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
                        end: Alignment.topCenter)),
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
  var styleDrawerText = TextStyle(color: Colors.white, fontSize: 25);
  var seacrhController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang chủ'),
        actions: [
          Icon(Icons.copyright_outlined),
          // FutureBuilder<UserModel>(
          //   future: getUser(LoginScreen.username),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return Center(child: Text(snapshot.data!.coin.toString()));
          //     } else {
          //       return Text("Lỗi ");
          //     }
          //   },
          // )
          StreamBuilder<UserModel>(
            stream: getUserstream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(child: Text(snapshot.data!.coin.toString()));
              } else {
                return Text("Lỗi ");
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff001327),
        child: Column(
          children: [
            DrawerHeader(
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/VibuComic.png'),
              ),
            ),
            Container(
              color: Color.fromARGB(255, 6, 34, 85),
              child: GestureDetector(
                onTap: () async {
                  await Future.delayed(Duration(microseconds: 200));
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.view_column, color: Colors.white),
                  title: Text(
                    "Thư viện",
                    style: styleDrawerText,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              color: Color.fromARGB(255, 6, 34, 85),
              child: GestureDetector(
                onTap: () async {
                  await Future.delayed(Duration(microseconds: 200));
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.white),
                  title: Text(
                    "Thông tin cá nhân",
                    style: styleDrawerText,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
            Container(
              color: Color.fromARGB(255, 6, 34, 85),
              child: GestureDetector(
                onTap: () async {
                  await Future.delayed(Duration(microseconds: 200));
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                },
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    "Đăng xuất",
                    style: styleDrawerText,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<Truyen>>(
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
                    crossAxisCount: 2,
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
    );
  }
}
