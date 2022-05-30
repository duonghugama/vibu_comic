import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomeScrene extends StatefulWidget {
  @override
  State<UserHomeScrene> createState() => _UserHomeScreneState();
}

class _UserHomeScreneState extends State<UserHomeScrene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Trang chủ'),
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 20,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed("/user/truyen");
            },
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/anhtruyen.jpg'),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
