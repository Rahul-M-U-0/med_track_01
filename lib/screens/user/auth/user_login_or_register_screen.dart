import 'package:flutter/material.dart';
import 'package:med_track_01/screens/login_screen.dart';
import 'package:med_track_01/screens/user/auth/user_register_screen.dart';

class UserLoginOrRegisterScreen extends StatefulWidget {
  const UserLoginOrRegisterScreen({super.key});

  @override
  State<UserLoginOrRegisterScreen> createState() =>
      _UserLoginOrRegisterScreenState();
}

class _UserLoginOrRegisterScreenState extends State<UserLoginOrRegisterScreen> {
  bool showLoginScreen = true;

  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(
        registerTap: toggleScreens,
        role: "User",
      );
    } else {
      return UserRegistrationScreen(
        loginTap: toggleScreens,
      );
    }
  }
}
