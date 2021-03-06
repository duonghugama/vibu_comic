import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:vibu_comic/model/chaptruyen.dart';
import 'package:vibu_comic/model/truyen.dart';
import 'package:vibu_comic/screen/nguoiDoc/doctruyen_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/doctruyen_screen2.dart';
import 'package:vibu_comic/screen/nguoiDoc/trangchu_screen.dart';

class TruyenScreen extends StatefulWidget {
  final String idTruyen;

  const TruyenScreen({Key? key, required this.idTruyen}) : super(key: key);
  @override
  State<TruyenScreen> createState() => _TruyenScreenState(idTruyen);
}

class ThongTinTruyenTilte extends StatelessWidget {
  final Image image;
  final String? tenTruyen;
  final String? tenKhac;
  final List<String>? theLoai;
  final String? moTa;
  final int? gia;
  final String? tacGia;

  const ThongTinTruyenTilte(
      {Key? key,
      required this.image,
      required this.tenTruyen,
      required this.tenKhac,
      required this.theLoai,
      required this.moTa,
      required this.gia,
      required this.tacGia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[300],
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ClipRRect(borderRadius: BorderRadius.circular(10), child: image),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tenTruyen!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "T??c gi???: " + tacGia.toString(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "T??n kh??c: " + tenKhac!,
                          style: TextStyle(),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Th??? lo???i: " + theLoai!.join(",")),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Gi??: " + gia.toString() + "??/Ch????ng",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_outline),
                    label: Text("Th??m v??o th?? vi???n"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.play_arrow),
                    label: Text("?????c truy???n"),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ExpandablePanel(
                theme: ExpandableThemeData(tapBodyToCollapse: true, tapBodyToExpand: true),
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "M?? t??? truy???n",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                collapsed: Text(
                  moTa!,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(moTa!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TruyenScreenState extends State<TruyenScreen> {
  final String idTruyen;
  static Truyen truyen = Truyen(
      linkAnhTruyen: "",
      daHoanThanh: false,
      gia: 0,
      idTruyen: "",
      tenTruyen: "",
      tenKhac: "",
      tacGia: "",
      theLoai: [],
      moTa: "");
  _TruyenScreenState(this.idTruyen);

  Stream<List<ChapTruyen>> getChaps() {
    return FirebaseFirestore.instance
        .collection("comics")
        .doc(idTruyen.trim())
        .collection("chaps")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => ChapTruyen.fromJson(e.data())).toList());
  }

  Future<Truyen> getTruyen(String idTruyen) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('comics').where('id', isEqualTo: idTruyen).get();
    truyen = Truyen.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
    return Truyen.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<Truyen>(
              future: getTruyen(idTruyen),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return SizedBox(
                    child: ThongTinTruyenTilte(
                      image: Image.network(
                        '${snapshot.data?.linkAnhTruyen}',
                        fit: BoxFit.fill,
                      ),
                      gia: snapshot.data?.gia,
                      moTa: snapshot.data?.moTa,
                      tenKhac: snapshot.data?.tenKhac,
                      tenTruyen: snapshot.data?.tenTruyen,
                      theLoai: List<String>.from(snapshot.data!.theLoai.toList()),
                      tacGia: snapshot.data?.tacGia,
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Center(
                  child: Text('L???i load ???nh'),
                );
              }),
          Expanded(
              child: StreamBuilder<List<ChapTruyen>>(
            stream: getChaps(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("L???i t???i chap truy???n"),
                );
              } else if (snapshot.hasData) {
                final chaps = snapshot.data!;
                if (chaps.isEmpty) {
                  return Center(
                    child: Text(
                      "Truy???n ch??a c?? ch????ng n??o ????",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                return ListView(
                  children: chaps.map(buildChap).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }

  Widget buildChap(ChapTruyen chap) {
    List<String> idUserUnlock = List<String>.from(chap.idUserUnlock);
    return ListTile(
      title: GestureDetector(
        onTap: () {
          if (idUserUnlock.contains(UserHomeScrene.userModel.id)) {
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => DocTruyenScreen(idTruyen, chap.idChap)),
              MaterialPageRoute(builder: (context) => DocTruyenScreen2(chap.linkanh)),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text('B???n ch??a mua ch????ng n??y!!'),
                        Text('B???n c?? mu???n mua b???ng VibuCoin kh??ng?'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        try {
                          final docUser =
                              FirebaseFirestore.instance.collection('users').doc(UserHomeScrene.userModel.id);
                          final chaps = FirebaseFirestore.instance
                              .collection("comics")
                              .doc(idTruyen.trim())
                              .collection("chaps")
                              .doc(chap.tenChap);
                          idUserUnlock.add(UserHomeScrene.userModel.id);
                          chaps.update({'idUserUnlock': idUserUnlock});
                          docUser.update({'coin': UserHomeScrene.userModel.coin - truyen.gia});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Mua truy???n th??nh c??ng"),
                            ),
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("C?? l???i x???y ra!!!"),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text("C??"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kh??ng"),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Text(
          chap.tenChap,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          idUserUnlock.contains(UserHomeScrene.userModel.id) ? Icon(Icons.lock_open) : Icon(Icons.lock),
        ],
      ),
    );
  }
}
