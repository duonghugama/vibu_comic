import 'package:flutter/material.dart';

class TruyenScreen extends StatefulWidget {
  @override
  State<TruyenScreen> createState() => _TruyenScreenState();
}

class ThongTinTruyenTilte extends StatelessWidget {
  final Image image;
  final String tenTruyen;
  final String tenKhac;
  final List<String> theLoai;
  final String moTa;
  final int gia;

  const ThongTinTruyenTilte(
      {Key? key,
      required this.image,
      required this.tenTruyen,
      required this.tenKhac,
      required this.theLoai,
      required this.moTa,
      required this.gia})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: image,
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    tenTruyen,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tên khác: " + tenKhac,
                    style: TextStyle(),
                  ),
                  Text("Thể loại: " + theLoai.join(",")),
                  Text(
                    "Giá: " + gia.toString() + "đ/Chương",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TruyenScreenState extends State<TruyenScreen> {
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
        title: Text("OnePunch-Man"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.3,
            width: size.width,
            child: ThongTinTruyenTilte(
                image: Image(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/anhtruyen.jpg'),
                ),
                gia: 1500,
                moTa: "dgkajdsglk",
                tenKhac: "Thánh phồng tôm",
                tenTruyen: "OnePunch-Man",
                theLoai: const ["Action", "Manga"]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      print("Chương $index");
                    },
                    child: Text(
                      "Chương " + index.toString(),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.bookmark_border),
                      Icon(Icons.lock),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}