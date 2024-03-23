import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/screens/getstarted_screen.dart';
import 'package:med_track_01/screens/main_auth_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          bool hasdata = snapshot.hasData;
          if (hasdata) {
            return MainAuthScreen(
              hasdata: hasdata,
            );
          } else {
            return const GetStartedScreen();
          }
        },
      ),
    );
  }
}
