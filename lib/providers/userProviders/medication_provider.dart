import 'package:flutter/material.dart';

class UserCreateMedicineProvider extends ChangeNotifier {
  String name = "";
  String description = "";
  int dosage = 0;
  String? type;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? time;
  DateTime currentDate = DateTime.now();

  Map<String, dynamic> medication = {};

  void getCurrentDate(value) {
    currentDate = value;
    notifyListeners();
  }

  void getName(value) {
    name = value;
    notifyListeners();
  }

  void getDescription(value) {
    description = value;
    notifyListeners();
  }

  void getDosage(value) {
    dosage = value;
    notifyListeners();
  }

  void getType(value) {
    type = value;
    notifyListeners();
  }

  void getStartDate(value) {
    startDate = value;
    notifyListeners();
  }

  void getEndDate(value) {
    endDate = value;
    notifyListeners();
  }

  void getTime(value) {
    time = value;
    notifyListeners();
  }

  void setDataToMap(value) {
    medication = {
      "name": name,
      "description": description,
      "dosage": dosage,
      "type": type,
      "startDate": startDate,
      "endDate": endDate,
      "time": time,
      "id": value,
    };

    name = "";
    description = "";
    dosage = 0;
    type = null;
    startDate = null;
    endDate = null;
    time = null;
    notifyListeners();
  }

  void clearAll() {
    medication = {};
    name = "";
    description = "";
    dosage = 0;
    type = null;
    startDate = null;
    endDate = null;
    time = null;
  }
}
