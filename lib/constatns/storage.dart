import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'string.dart';

class UserStorage {
  String? userTypeData;
  String? emailData;
  String? tokenData;
  bool? isAdmin;

  // get getEmail => _email.value;
  // get getuserType => _userType.value;
  // get getToken => _token.value;

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emailData = prefs.getString(email)!;
    userTypeData = prefs.getString(userType)!;
    tokenData = prefs.getString(token)!;

    debugPrint(emailData);
    debugPrint(userTypeData);
    debugPrint(tokenData);

    if (userTypeData == "admin") {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  void setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(email, value);
  }

  void setUserType(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userType, value);
  }

  void setUserToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(token, value);
  }
}
