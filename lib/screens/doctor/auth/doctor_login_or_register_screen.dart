import 'package:flutter/material.dart';
import 'package:med_track_01/screens/doctor/auth/doctor_login_screen.dart';
import 'package:med_track_01/screens/doctor/auth/doctor_register_screen.dart';

class DoctorLoginOrRegisterScreen extends StatefulWidget {
  const DoctorLoginOrRegisterScreen({super.key});

  @override
  State<DoctorLoginOrRegisterScreen> createState() =>
      _DoctorLoginOrRegisterScreenState();
}

class _DoctorLoginOrRegisterScreenState
    extends State<DoctorLoginOrRegisterScreen> {
  bool showLoginScreen = true;

  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return DoctorLoginScreen(
        registerTap: toggleScreens,
      );
    } else {
      return DoctorRegistrationScreen(
        loginTap: toggleScreens,
      );
    }
  }
}
