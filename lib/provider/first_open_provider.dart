import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstOpenProvider extends ChangeNotifier {
  late SharedPreferences prefs;
  bool isNewUser = false;

  //download cover number
  

  Future<void> getShared() async {
    prefs = await SharedPreferences.getInstance();
    isNewUser = await prefs.getBool("isNewUser") ?? false;

    notifyListeners();
  }

  Future<void> setShared() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("isNewUser", true);
    notifyListeners();
  }

  bool isNewUserFunction() {
    return isNewUser;
  }

  notifyListeners();
}
