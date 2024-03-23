import 'package:flutter/material.dart';

class StoreProfileProvider extends ChangeNotifier {
  String userName = "";
  String userPhone = "";
  String email = "";
  String address = "";
  String license = "";
  String pic =
      "https://firebasestorage.googleapis.com/v0/b/med-tracker-748ec.appspot.com/o/avatar.png?alt=media&token=0d660f92-82af-45fa-af65-c0db46bc046d";

  getEmail(value) {
    email = value;
    notifyListeners();
  }

  getLicense(value) {
    license = value;
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
    license = "";
    pic =
        "https://firebasestorage.googleapis.com/v0/b/med-tracker-748ec.appspot.com/o/user.webp?alt=media&token=74f50d41-981a-4983-aa52-ba860ac7a792";
    notifyListeners();
  }
}
