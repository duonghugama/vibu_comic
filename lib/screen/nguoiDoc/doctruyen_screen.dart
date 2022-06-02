import 'package:flutter/material.dart';

class DocTruyenScreen extends StatefulWidget {
  @override
  State<DocTruyenScreen> createState() => _DocTruyenScreenState();
}

class _DocTruyenScreenState extends State<DocTruyenScreen> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: false, // Set it to false to prevent panning.
      minScale: 1,
      maxScale: 5,
      child: Scaffold(
        body: ListView.builder(
          itemCount: 17,
          itemBuilder: (context, index) {
            if (index < 9) {
              return Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/OnePunch-Man/Anh0${index + 1}.png'),
              );
            } else {
              return Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/OnePunch-Man/Anh${index + 1}.png'),
              );
            }
          },
        ),
      ),
    );
  }
}
