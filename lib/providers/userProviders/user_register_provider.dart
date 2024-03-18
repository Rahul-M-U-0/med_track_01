import 'package:flutter/material.dart';

class UserRegisterProvider extends ChangeNotifier {
  String name = "";
  String email = "";
  String password = "";
  String phone = "";

  void nameController(value) {
    if (value != "") {
      name = value;
      notifyListeners();
    }
  }

  void phNumberController(value) {
    phone = value;
    notifyListeners();
  }

  void emailController(value) {
    email = value;
    notifyListeners();
  }

  void passwordController(value) {
    password = value;
    notifyListeners();
  }

  void deleteName() {
    name = "";
  }

  void deletePassword() {
    password = "";
  }

  void deleteEmail() {
    email = "";
  }

  void deletePhone() {
    phone = "";
  }
}
