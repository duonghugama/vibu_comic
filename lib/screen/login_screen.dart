import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vibu_comic/screen/nguoiDoc/trangchu_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreenState();
  Future signIn() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: userNameController.text)
        .get();
    String email = snapshot.docs[0]["email"];
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: passwordController.text.trim(),
    );
  }

  @override
  void initState() {
    userNameController.text = "admin";
    passwordController.text = "12345678";
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return loginWidget(size);
          }
          if (!snapshot.hasData) {
            return loginWidget(size);
          } else {
            return UserHomeScrene();
          }
        },
      ),
    );
  }

  Widget loginWidget(Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "Đăng nhập",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: "Tên đăng nhập"),
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: const InputDecoration(labelText: "Mật khẩu"),
              obscureText: true,
              controller: passwordController,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: GestureDetector(
              onTap: () => {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ConnectPage()))
                Navigator.of(context).pushNamed('/signup')
              },
              child: const Text(
                "Chưa có tài khoản? Đăng ký",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: RaisedButton(
              onPressed: signIn,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 255, 236, 34),
                    Color.fromARGB(255, 255, 177, 41),
                  ]),
                ),
                padding: const EdgeInsets.all(0),
                child: const Text(
                  "Đăng nhập",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          //Text(currentState.hello),
        ],
      ),
    );
  }
}
