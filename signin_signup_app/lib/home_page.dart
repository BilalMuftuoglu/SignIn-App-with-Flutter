import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup_app/sign_in_page.dart';
import 'package:signin_signup_app/user_model.dart';

import 'shared_preferences.dart';

class HomePage extends StatelessWidget {
  String usernameOrEmail;
  HomePage({Key? key, required this.usernameOrEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn App"),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      
                      title: Text("Are you sure to log out?"),
                      actions: [
                        TextButton(child: Text("No"), onPressed: () {
                        Navigator.pop(context);
                        }),
                        TextButton(child: Text("Yes"), onPressed: () {
                          prefLogOut();
                          
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignInPage())),
                            );

                            Fluttertoast.showToast(
                                msg: "Çıkış yaptınız",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.amber,
                                textColor: Colors.white,
                                fontSize: 16.0);
                        })
                      ],
                    );
                  });
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: ((context) => SignInPage())),
              // );
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.logout)),
          )
        ],
      ),
      body: FutureBuilder(future: Shared().getUser(usernameOrEmail),builder: (context, snapshot) {
        if(snapshot.hasData){
          User myUser =  (snapshot.data as User); snapshot.data;
          return Center(child: Text("Hoşgeldin: "+myUser.userName,style: TextStyle(fontSize: 30),));
        }else if(snapshot.hasError){
          return Center(child: Text("Bir hata oluştu!"));
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },),
    );
  }

  void prefLogOut() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("isLoggedIn", ["false",""]);
  }
}
