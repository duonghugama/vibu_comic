import 'package:flutter/material.dart';

class DocTruyenScreen extends StatefulWidget {
  @override
  State<DocTruyenScreen> createState() => _DocTruyenScreenState();
}

class _DocTruyenScreenState extends State<DocTruyenScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/OnePunch-Man/Anh${index}'),
          );
        },
      ),
    );
  }
}
