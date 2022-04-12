import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup_app/first_page.dart';
import 'package:signin_signup_app/home_page.dart';
import 'package:signin_signup_app/sign_in_page.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      List<String> isLoggedIn = prefs.getStringList("isLoggedIn") ?? ["false",""];
      if (isLoggedIn[0] == "true") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => HomePage(usernameOrEmail: isLoggedIn[1]))));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignInPage()));
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => FirstPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
