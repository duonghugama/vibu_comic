import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  Future createUser({username, pass, email}) async {
    signUp(email, pass);
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = UserModel(
      id: docUser.id,
      coin: 0,
      pass: pass,
      email: email,
      username: username,
      isAdmin: false,
    );
    final json = user.toJson();
    await docUser.set(json);
  }

  Future signUp(String email, String pass) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Form(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "Đăng ký",
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
                child: TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(labelText: "Tên đăng nhập"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tên đăng nhập không được để trống';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                      return 'Email chưa chính xác';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Mật khẩu"),
                  obscureText: true,
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Mật khẩu có tối thiểu 6 ký tự';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Nhập lại Mật khẩu"),
                  obscureText: true,
                  controller: confirmpasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value != passwordController.text) {
                      return 'Mật khẩu chưa chính xác';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),

              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Thông tin chưa chính xác')),
                      );
                    }
                    if (confirmpasswordController.text != passwordController.text) {
                      Fluttertoast.showToast(msg: "Mật khẩu chưa chính xác");
                      return;
                    } else {
                      if (userNameController.text.isEmpty) {
                        return;
                      }
                      createUser(
                          username: userNameController.text,
                          pass: passwordController.text,
                          email: emailController.text);
                      Navigator.of(context).pushNamed('/');
                    }
                  },
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
                      "Đăng ký",
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
        ),
      ),
    );
  }
}
