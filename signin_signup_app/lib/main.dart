import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:signin_signup_app/control_page.dart';
import 'package:signin_signup_app/first_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter SignIn App',
      home: ControlPage()
    );
  }
}