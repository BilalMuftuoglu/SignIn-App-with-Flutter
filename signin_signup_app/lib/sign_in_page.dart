import 'package:flutter/material.dart';
import 'package:signin_signup_app/home_page.dart';
import 'package:signin_signup_app/sign_up_page.dart';
import 'shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _loginFormKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _passwordVisibility = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
          key: _loginFormKey,
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
                    "Login",
                    style: TextStyle(
                        color: Color.fromARGB(255, 42, 113, 172),
                        fontSize: yukseklik * 0.05),
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
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Enter an Email or Username",
                        labelText: "Email/Username"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: _passwordVisibility,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.length < 8) {
                        return "En az 8 karakter olmalı!";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisibility = !_passwordVisibility;
                            });
                          },
                        ),
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
                          child: Text("New here? Register"),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignUpPage())),
                            );
                          },
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            Shared()
                                .checkUser(_passwordController.text,
                                    _emailController.text)
                                .then((value) {
                              if (value == true) {
                                Fluttertoast.showToast(
                                    msg: "Başarıyla giriş yapıldı",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => HomePage(
                                          usernameOrEmail:
                                              _emailController.text))),
                                );
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Lütfen geçerli bir hesap giriniz!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }).onError((error, stackTrace) {
                              Fluttertoast.showToast(
                                  msg: "Bir hata oluştu " + error.toString(),
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            });
                          }
                        },
                        child: Text(
                          "Login",
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
