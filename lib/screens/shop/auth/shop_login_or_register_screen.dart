import 'package:flutter/material.dart';
import 'package:med_track_01/screens/login_screen.dart';
import 'package:med_track_01/screens/shop/auth/shop_register_screen.dart';

class ShopLoginOrRegistrationScreen extends StatefulWidget {
  const ShopLoginOrRegistrationScreen({super.key});

  @override
  State<ShopLoginOrRegistrationScreen> createState() =>
      _ShopLoginOrRegistrationScreenState();
}

class _ShopLoginOrRegistrationScreenState
    extends State<ShopLoginOrRegistrationScreen> {
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
        role: "Store",
      );
    } else {
      return ShopRegistrationScreen(
        loginTap: toggleScreens,
      );
    }
  }
}
