import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup_app/shared_preferences.dart';
import 'package:signin_signup_app/sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"), fit: BoxFit.fill)),
        width: genislik,
        height: yukseklik,
        child: SafeArea(
            child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _signUpFormKey,
          child: Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SizedBox(), flex: 3),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Color.fromARGB(255, 42, 113, 172),
                        fontSize: yukseklik * 0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "En az 3 karakter olmalı!";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Enter a username",
                        labelText: "Username"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "En az 3 karakter olmalı!";
                      } else if (!value.contains("@")) {
                        return "Lütfen geçerli bir mail giriniz!";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Enter an Email",
                        labelText: "Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "En az 8 karakter olmalı!";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Enter password",
                        labelText: "Password"),
                  ),
                ),
                Expanded(child: SizedBox(), flex: 1),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 24),
                        child: InkWell(
                          child: Text("Already Member? Login"),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignInPage())),
                            );
                          },
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            Shared().setUser(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text);
                            Fluttertoast.showToast(
                                msg: "Başarıyla kayıt oldunuz",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignInPage())),
                            );
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white, fontSize: yukseklik * 0.02),
                        ),
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(genislik * 0.3, yukseklik * 0.06),
                            side: BorderSide(color: Colors.white, width: 1.0)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
