import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier {
  String userName = "";
  String userPhone = "";
  String email = "";
  String address = "";
  String pic = "assets/images/user.webp";

  getEmail(value) {
    email = value;
    notifyListeners();
  }

  getAddress(value) {
    address = value;
    notifyListeners();
  }

  getPic(value) {
    pic = value;
    notifyListeners();
  }

  getUserPhone(value) {
    userPhone = value;
    notifyListeners();
  }

  getUserName(value) {
    userName = value;
    notifyListeners();
  }

  clearAllProfileData() {
    userName = "";
    userPhone = "";
    email = "";
    address = "";
    pic = "assets/images/user.webp";
    notifyListeners();
  }
}
