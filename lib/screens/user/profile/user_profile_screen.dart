// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/screens/getstarted_screen.dart';
import 'package:med_track_01/screens/user/profile/user_editprofile_screen.dart';
import 'package:med_track_01/screens/user/widgets/get_user_profile.dart';

import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key, required this.profileProvider});

  UserProfileProvider profileProvider;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Future signUserOut(
      UserProfileProvider profileProvider, BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    profileProvider.clearAllProfileData();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const GetStartedScreen(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    getProfileInfo(widget.profileProvider);
    super.initState();
  }

  void editProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserEditProfileScreen(),
      ),
    );
  }

  void changePassword(BuildContext context) {}

  void submitProfile(BuildContext context) {}

  Future<void> deleteAccount(BuildContext context) async {
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
      String userId = FirebaseAuth.instance.currentUser!.uid;

      FirebaseFirestore.instance.collection("users").doc(userId).delete();
      await FirebaseAuth.instance.currentUser!
          .delete()
          .then((value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const GetStartedScreen(),
              ),
              (route) => false));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
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
          backgroundColor: const Color(0xff04516f),
          title: const Text(
            'User Profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Consumer<UserProfileProvider>(
            builder: (context, providerValue, child) {
              return Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        radius: screenSize.width * 0.20,
                        backgroundColor: const Color(0xff15c79a),
                        child: CircleAvatar(
                          radius: screenSize.width * 0.20 - 2,
                          backgroundImage: AssetImage(providerValue.pic),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        providerValue.userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            providerValue.email,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffffffff),
                            ),
                          ),
                          const Text('   |   '),
                          Text(
                            providerValue.userPhone,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        providerValue.address,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: screenSize.width * 0.5,
                    height: screenSize.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        editProfile(context);
                      },
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: screenSize.height * 0.08,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                changePassword(context);
                              },
                              icon: const Icon(
                                Icons.key,
                                size: 30,
                                color: Colors.white,
                              ),
                              label: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Change Password",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: screenSize.height * 0.08,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                signUserOut(providerValue, context);
                              },
                              icon: const Icon(
                                Icons.logout,
                                size: 30,
                                color: Colors.white,
                              ),
                              label: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Log Out",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: screenSize.height * 0.08,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.transparent),
                              onPressed: () {
                                deleteAccount(context);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.red,
                              ),
                              label: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Delete Account",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 30,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
