import 'package:flutter/material.dart';

class StoreRegisterProvider extends ChangeNotifier {
  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  String license = "";

  void nameController(value) {
    if (value != "") {
      name = value;
      notifyListeners();
    }
  }

  void licenseController(value) {
    license = value;
    notifyListeners();
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

  void deleteLicense() {
    license = "";
  }
}
