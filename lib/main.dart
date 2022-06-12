import 'package:flutter/material.dart';
import 'package:vibu_comic/firebase_options.dart';
import 'package:vibu_comic/screen/admin/trangchu_screen.dart';
import 'package:vibu_comic/screen/login_screen.dart';
import 'package:vibu_comic/screen/nguoiDoc/trangchu_screen.dart';
import 'package:vibu_comic/screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

const apiKey = "AIzaSyCcNFxmTIO5wEameFIaQ_h2CQFBSYTD4TI";
const projectID = "vibu-comic-86908";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAppCheck.instance.activate();
  runApp(
    MyPhoneApp(),
  );
  // if (!Platform.isWindows) {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //   // await FirebaseAppCheck.instance.activate();
  //   runApp(
  //     MyPhoneApp(),
  //   );
  // } else {
  //   Firestore.initialize(projectID);
  //   forWindow.FirebaseDart.setup();
  //   runApp(
  //     MyWindowApp(),
  //   );
  // }
}

class MyWindowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHomeScreen(),
    );
  }
}

class MyPhoneApp extends StatelessWidget {
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
      },
    );
  }
}
