import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup_app/user_model.dart';

class Shared {
  Future<void> setUser(String userName, String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userName + email,
        jsonEncode(User(userName: userName, email: email, password: password)));
  }

  Future<bool> checkUser(String pw, String usernameOrEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String myUserKey = " ";
    late User user;
    preferences.getKeys().forEach((element) {
      if (element.contains(usernameOrEmail)) {
        myUserKey = element;
      }
    });

    String userString = preferences.getString(myUserKey) ?? "";
    
    if(userString != ""){
       user = User.fromJson(jsonDecode(userString));
    }else{
      user = User(userName: "", email: "", password: "");
    }
    

    if (user.userName == usernameOrEmail || user.email == usernameOrEmail) {
      if (user.password == pw) {
        preferences.setStringList("isLoggedIn", ["true",myUserKey.toString()]);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<User> getUser(String usernameOrEmail) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    late String myUserKey;
    preferences.getKeys().forEach((element) {
      if (element.contains(usernameOrEmail)) {
        myUserKey = element;
      }
    });

    String userString = preferences.getString(myUserKey) ?? "";
    User user = User.fromJson(jsonDecode(userString));
    return user;
  }
}
