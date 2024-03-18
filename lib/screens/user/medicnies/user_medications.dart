// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/screens/user/medicnies/add_medicine_screen.dart';
import 'package:med_track_01/screens/user/medicnies/user_medicines_screen.dart';

class UserMedicationScreen extends StatefulWidget {
  const UserMedicationScreen({
    super.key,
  });

  @override
  State<UserMedicationScreen> createState() => _UserMedicationScreenState();
}

class _UserMedicationScreenState extends State<UserMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("medications")
        .snapshots();
    return Scaffold(
      body: StreamBuilder(
        stream: firestore,
        builder: (context, snapshot) {
          if ((snapshot.data?.docs.length).toString() == "null" ||
              (snapshot.data?.docs.length).toString() == "0") {
            return const UserAddMedicineScreen();
          } else {
            return UserMedicinesScreen(snapshot: snapshot);
          }
        },
      ),
    );
  }
}
