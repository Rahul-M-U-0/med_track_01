// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/providers/userProviders/user_login_provider.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/screens/getstarted_screen.dart';
import 'package:med_track_01/screens/user/user_bnb.dart';
import 'package:med_track_01/screens/user/widgets/get_user_profile.dart';

import 'package:provider/provider.dart';

class UserLoginScreen extends StatefulWidget {
  final Function()? registerTap;
  const UserLoginScreen({super.key, required this.registerTap});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  Future signUserIn(UserLoginProvider providerValue,
      UserProfileProvider profileProvider, BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: const Color(0xff04516f),
            color: Colors.grey[500],
          ),
        );
      },
    );
    try {
      UserCredential result =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: providerValue.email.trim(),
        password: providerValue.password.trim(),
      );

      FirebaseFirestore.instance
          .collection("users")
          .doc(result.user!.uid)
          .get()
          .then((value1) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserBottomNavi(),
          ),
        );
        providerValue.deleteEmail();
        providerValue.deletePassword();
      });
      await getProfileInfo(profileProvider);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'channel-error') {
        showErrorMessage('Enter username and password');
      } else if (e.code == 'invalid-credential') {
        showErrorMessage('Invalied Email or Password');
      } else {
        showErrorMessage(e.code);
      }
    }
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff04516f),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const GetStartedScreen(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          title: const Text(
            'LogIn As user',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff04516f),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Consumer<UserLoginProvider>(
                builder: (context, providerValue, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: screenSize.width * 0.25,
                        backgroundImage:
                            const AssetImage('assets/images/user.webp'),
                        backgroundColor: const Color(0xff04516f),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      TextField(
                        onChanged: (value) {
                          providerValue.emailNotifier(value);
                        },
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: const TextStyle(
                            color: Color(0xffffffff),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white24,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff15c79a),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        onChanged: (value) {
                          providerValue.passwordNotifier(value);
                        },
                        obscureText: true,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            color: Color(0xffffffff),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white24,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff15c79a),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.03,
                      ),
                      SizedBox(
                        height: 45,
                        width: 200,
                        child: Consumer<UserProfileProvider>(
                          builder: (context, profileProvider, child) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff15c79a),
                              ),
                              onPressed: () {
                                signUserIn(
                                    providerValue, profileProvider, context);
                              },
                              child: const Text(
                                'LogIn',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 2,
                              width: screenSize.width * 0.35,
                              color: Colors.white),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "or",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 2,
                            width: screenSize.width * 0.35,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "I don't have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          TextButton(
                            onPressed: widget.registerTap,
                            child: const Text(
                              "Register now",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
