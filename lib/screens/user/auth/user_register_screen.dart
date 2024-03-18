// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/providers/userProviders/user_register_provider.dart';
import 'package:med_track_01/screens/getstarted_screen.dart';
import 'package:med_track_01/screens/user/user_bnb.dart';
import 'package:med_track_01/screens/user/widgets/get_user_profile.dart';

import 'package:provider/provider.dart';

class UserRegistrationScreen extends StatefulWidget {
  final Function()? loginTap;
  const UserRegistrationScreen({super.key, required this.loginTap});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  Future signUserUp(UserRegisterProvider providerValue,
      UserProfileProvider profileProvider, BuildContext context) async {
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
      if (providerValue.name.trim() != "" &&
          providerValue.password.trim() != "" &&
          providerValue.email.trim() != "" &&
          providerValue.phone.trim() != "") {
        FocusManager.instance.primaryFocus?.unfocus();
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: providerValue.email.trim(),
                password: providerValue.password.trim());

        result.user?.updateDisplayName(providerValue.name.trim());

        Map<String, dynamic> userData = {
          "name": providerValue.name.trim(),
          "email": providerValue.email.trim(),
          "phone": providerValue.phone.trim(),
          "address": "",
          "pic": "assets/images/user.webp"
        };
        FirebaseFirestore.instance
            .collection("users")
            .doc(result.user!.uid)
            .set(userData);

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
      } else {
        Navigator.pop(context);
        showErrorMessage('Please fill out all fields to Continue');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-email') {
        showErrorMessage('Invalid email');
      } else if (e.code == 'weak-password') {
        showErrorMessage('Weak password');
      } else if (e.code == 'channel-error') {
        showErrorMessage('Enter email and password');
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage('Account already exist!');
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
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff04516f),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Consumer<UserRegisterProvider>(
                builder: (context, providerValue, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.1,
                      ),
                      TextField(
                        obscureText: false,
                        onChanged: (value) {
                          providerValue.nameController(value);
                        },
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: "User Name",
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
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        onChanged: (value) {
                          providerValue.phNumberController(value);
                        },
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: "Phone Number",
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
                        obscureText: false,
                        onChanged: (value) {
                          providerValue.emailController(value);
                        },
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: "Email",
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
                        obscureText: true,
                        onChanged: (value) {
                          providerValue.passwordController(value);
                        },
                        style: const TextStyle(
                          color: Color(0xffffffff),
                        ),
                        decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: "password",
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
                        height: 30,
                      ),
                      SizedBox(
                        height: 45,
                        width: 200,
                        child: Consumer<UserProfileProvider>(
                          builder: (context, profileProvider, child) {
                            return ElevatedButton(
                              onPressed: () {
                                signUserUp(
                                    providerValue, profileProvider, context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff15c79a),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
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
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "I already have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          TextButton(
                            onPressed: widget.loginTap,
                            child: const Text(
                              "SignIn",
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
