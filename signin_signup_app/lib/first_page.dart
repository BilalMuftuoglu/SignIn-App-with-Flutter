import 'package:flutter/material.dart';
import 'package:signin_signup_app/sign_in_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var genislik = MediaQuery.of(context).size.width;
    var yukseklik = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
      width: genislik,
      height: yukseklik,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 0, 0, 24.0),
        child: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlutterLogo(
                  size: yukseklik * 0.1,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: yukseklik * 0.05,
                      color: Color.fromARGB(255, 22, 77, 122)),
                ),
                Text(
                  "So let's start",
                  style:
                      TextStyle(fontSize: yukseklik * 0.03, color: Colors.blue),
                ),
                SizedBox(
                  height: yukseklik * 0.25,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SignInPage())),
                                );
                              },
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: yukseklik * 0.02),
                              ),
                              style: OutlinedButton.styleFrom(
                                  minimumSize:
                                      Size(genislik * 0.3, yukseklik * 0.06),
                                  side: BorderSide(
                                      color: Colors.white, width: 1.0)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.fill)),
    ));
  }
}
