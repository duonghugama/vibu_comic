import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vibu_comic/model/truyen.dart';

class UserHomeScrene extends StatefulWidget {
  @override
  State<UserHomeScrene> createState() => _UserHomeScreneState();
}

class _UserHomeScreneState extends State<UserHomeScrene> {
  Stream<List<Truyen>> readComics() => FirebaseFirestore.instance
      .collection('comics')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((e) => Truyen.fromJson(e.data())).toList());

  Widget buildTruyen(Truyen truyen) => Card(
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            Image.network(truyen.linkAnhTruyen, fit: BoxFit.fill),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Text(
                    truyen.tenTruyen,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
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
        actions: const [
          Icon(Icons.copyright_outlined),
          Center(child: Text('99999')),
        ],
      ),
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(200)),
        child: Drawer(
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
      floatingActionButton: AnimSearchBar(
        rtl: true,
        suffixIcon: Icon(Icons.search),
        closeSearchOnSuffixTap: true,
        helpText: 'Nhập tên truyện',
        width: size.width * 0.9,
        textController: seacrhController,
        onSuffixTap: () {
          setState(
            () {
              seacrhController.clear();
            },
          );
        },
      ),
    );
  }
}
