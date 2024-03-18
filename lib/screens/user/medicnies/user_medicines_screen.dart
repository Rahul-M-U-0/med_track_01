// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:med_track_01/providers/userProviders/medication_provider.dart';
import 'package:med_track_01/screens/user/medicnies/add_medicine_screen.dart';
import 'package:med_track_01/screens/user/medicnies/edit_medication_screen.dart';
import 'package:provider/provider.dart';

class UserMedicinesScreen extends StatefulWidget {
  UserMedicinesScreen({super.key, required this.snapshot});
  AsyncSnapshot snapshot;

  @override
  State<UserMedicinesScreen> createState() => _UserMedicinesScreenState();
}

class _UserMedicinesScreenState extends State<UserMedicinesScreen> {
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
    return SafeArea(
      child: Consumer<UserCreateMedicineProvider>(
        builder: (context, providerValue, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xff04516f),
              title: const Text(
                "Medicines",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              automaticallyImplyLeading: false,
            ),
            body: SafeArea(
              child: ListView.builder(
                itemCount: widget.snapshot.data?.docs.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) {
                  if (!widget.snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    String name = widget.snapshot.data?.docs[index]["name"];
                    String description =
                        widget.snapshot.data.docs[index]["description"];

                    int dosage = widget.snapshot.data.docs[index]["dosage"];
                    DateTime startDate =
                        widget.snapshot.data.docs[index]["startDate"].toDate();
                    DateTime endDate =
                        widget.snapshot.data.docs[index]["endDate"].toDate();

                    Duration duration = endDate.difference(startDate);
                    String id = widget.snapshot.data.docs[index]["id"];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 5,
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: ((context) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditMedicationScreen(
                                          index: index,
                                          id: id,
                                        );
                                      },
                                    ),
                                  );
                                }),
                                backgroundColor: Colors.grey.shade100,
                                icon: Icons.edit,
                              ),
                              SlidableAction(
                                onPressed: ((context) async {
                                  try {
                                    String userId =
                                        FirebaseAuth.instance.currentUser!.uid;

                                    FirebaseFirestore.instance
                                        .collection("users")
                                        .doc(userId)
                                        .collection("medications")
                                        .doc(id)
                                        .delete();
                                  } catch (e) {
                                    showErrorMessage(e.toString());
                                  }
                                }),
                                backgroundColor: Colors.grey.shade100,
                                icon: Icons.delete,
                              ),
                            ]),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff04516f),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Dosage $dosage",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Days ${duration.inDays}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white60,
                              child: Image.asset(
                                "assets/images/pillspng.png",
                              ),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              description,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            floatingActionButton: SizedBox(
              width: 100,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const UserAddMedicineScreen(
                          leadback: true,
                        );
                      },
                    ),
                  );
                },
                label: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
                backgroundColor: const Color(0xff15c79a),
              ),
            ),
          );
        },
      ),
    );
  }
}
