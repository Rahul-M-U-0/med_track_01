// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:med_track_01/screens/user/auth/user_login_or_register_screen.dart';
import 'package:med_track_01/screens/user_bnb.dart';

class MainAuthScreen extends StatelessWidget {
  MainAuthScreen({super.key, required this.hasdata});

  bool hasdata;

  @override
  Widget build(BuildContext context) {
    if (hasdata) {
      return const UserBottomNavi();
    } else {
      return const UserLoginOrRegisterScreen();
    }
  }
}
