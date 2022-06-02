import 'package:flutter/material.dart';
import 'package:vibu_comic/screen/admin/trangchu_screen.dart';
import 'package:vibu_comic/screen/login_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/doctruyen_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/trangchu_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/truyen_screen.dart';
import 'package:vibu_comic/screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

const apiKey = "AIzaSyCcNFxmTIO5wEameFIaQ_h2CQFBSYTD4TI";
const projectID = "vibu-comic-86908";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff001327),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => LoginScreen(),
        "/signup": ((context) => SignUpScreen()),
        "/user/home": (context) => UserHomeScrene(),
        "/user/truyen": (context) => TruyenScreen(),
        "/user/doctruyen": (context) => DocTruyenScreen(),
        "/admin/home": (context) => AdminHomeScreen(),
      },
    );
  }
}
