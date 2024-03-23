// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/screens/user/profile/dialogbox_update_current_profile.dart';
import 'package:med_track_01/screens/user/widgets/get_profile.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  void cancel(UserProfileProvider profileProvider, BuildContext context) {
    getUserProfileInfo(profileProvider);
    Navigator.pop(context);
  }

  void submitProfile(
      UserProfileProvider profileProvider, BuildContext context) async {
    getUserProfileInfo(profileProvider);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff04516f),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return IconButton(
                onPressed: () {
                  cancel(profileProvider, context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              );
            },
          ),
          backgroundColor: const Color(0xff04516f),
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff),
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: SingleChildScrollView(
              child: Consumer<UserProfileProvider>(
                builder: (context, profileProvider, child) {
                  return Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.05,
                      ),
                      CircleAvatar(
                        radius: screenSize.width * 0.2,
                        backgroundImage: NetworkImage(profileProvider.pic),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
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
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            dialogBoxUpdateCurrentUserName(
                                context, userId, "User Name");
                          },
                          icon: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    profileProvider.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.keyboard,
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
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            dialogBoxUpdateCurrentPhone(
                                context, userId, "Phone");
                          },
                          icon: const Icon(
                            Icons.phone,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    profileProvider.userPhone,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.keyboard,
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
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            dialogBoxUpdateCurrentAddress(
                                context, userId, "Address");
                          },
                          icon: const Icon(
                            Icons.maps_home_work_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    profileProvider.address.isEmpty
                                        ? "Address"
                                        : profileProvider.address,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(
                                Icons.keyboard,
                                size: 30,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.08,
                      ),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            submitProfile(profileProvider, context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff15c79a),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ),
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
