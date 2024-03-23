import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splash() {
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const MainScreen();
            },
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    splash();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff04516f),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                radius: screenSize.width * 0.25,
                child: SizedBox(
                  child: Image.asset('assets/images/pillspng.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenSize.width * 0.9,
                  child: DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontFamily: 'Agne',
                    ),
                    child: Center(
                      child: AnimatedTextKit(
                        totalRepeatCount: 1,
                        pause: const Duration(microseconds: 1000),
                        animatedTexts: [
                          TypewriterAnimatedText('Medicine Tracker'),
                        ],
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
