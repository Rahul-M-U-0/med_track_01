import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/screens/user/widgets/get_profile.dart';
import 'package:provider/provider.dart';

dialogBoxUpdateCurrentUserName(context, userId, infoType) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          infoType,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.infinity,
          child: Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: profileProvider.userName,
                onChanged: (value) {
                  profileProvider.getUserName(value);
                },
              );
            },
          ),
        ),
        actions: [
          Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  getUserProfileInfo(profileProvider);
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              );
            },
          ),
          Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  if (infoType == "User Name") {
                    Map<String, String> updatedData = {
                      "name": profileProvider.userName,
                    };
                    FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(profileProvider.userName);
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(userId)
                        .update(updatedData);
                  }

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              );
            },
          ),
        ],
        actionsPadding: const EdgeInsets.only(
          right: 20,
          bottom: 20,
        ),
      );
    },
  );
}

dialogBoxUpdateCurrentPhone(context, userId, infoType) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          infoType,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.infinity,
          child: Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: profileProvider.userPhone,
                onChanged: (value) {
                  profileProvider.getUserPhone(value);
                },
              );
            },
          ),
        ),
        actions: [
          Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  getUserProfileInfo(profileProvider);
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              );
            },
          ),
          Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  if (infoType == "Phone") {
                    Map<String, String> updatedData = {
                      "phone": profileProvider.userPhone,
                    };

                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(userId)
                        .update(updatedData);
                  }

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              );
            },
          ),
        ],
        actionsPadding: const EdgeInsets.only(
          right: 20,
          bottom: 20,
        ),
      );
    },
  );
}

dialogBoxUpdateCurrentAddress(context, userId, infoType) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          infoType,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.infinity,
          child: Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: profileProvider.address,
                onChanged: (value) {
                  profileProvider.getAddress(value);
                },
              );
            },
          ),
        ),
        actions: [
          Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  getUserProfileInfo(profileProvider);
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              );
            },
          ),
          Consumer<UserProfileProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  if (infoType == "Address") {
                    Map<String, String> updatedData = {
                      "address": profileProvider.address,
                    };

                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(userId)
                        .update(updatedData);
                  }

                  Navigator.pop(context);
                },
                child: const Text("Save"),
              );
            },
          ),
        ],
        actionsPadding: const EdgeInsets.only(
          right: 20,
          bottom: 20,
        ),
      );
    },
  );
}
