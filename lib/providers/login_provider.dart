import 'package:flutter/material.dart';

class UserLoginProvider extends ChangeNotifier {
  String password = "";
  String email = "";

  void emailNotifier(index) {
    email = index;
    notifyListeners();
  }

  void passwordNotifier(index) {
    password = index;
    notifyListeners();
  }

  void deletePassword() {
    password = "";
    notifyListeners();
  }

  void deleteEmail() {
    email = "";
    notifyListeners();
  }
}
