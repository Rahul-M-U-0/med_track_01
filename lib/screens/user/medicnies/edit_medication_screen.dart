import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_track_01/providers/userProviders/medication_provider.dart';
import 'package:med_track_01/screens/user/medicnies/add_medicine_screen.dart';
import 'package:med_track_01/screens/user/medicnies/dialogbox_update_medication.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditMedicationScreen extends StatefulWidget {
  EditMedicationScreen({
    super.key,
    required this.index,
    required this.id,
  });
  int index;
  String id;

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("medications")
        .snapshots();
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff04516f),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Consumer<UserCreateMedicineProvider>(
            builder: (context, providerValue, child) {
              return IconButton(
                onPressed: () {
                  providerValue.clearAll();
                  Navigator.pop(context);
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
            'Edit Medicine',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff),
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: firestore,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: SingleChildScrollView(
                    child: Consumer<UserCreateMedicineProvider>(
                      builder: (context, providerValue, child) {
                        providerValue.name =
                            snapshot.data?.docs[widget.index]["name"];
                        providerValue.description =
                            snapshot.data?.docs[widget.index]["description"];
                        providerValue.dosage =
                            snapshot.data?.docs[widget.index]["dosage"];
                        providerValue.startDate = snapshot
                            .data?.docs[widget.index]["startDate"]
                            .toDate();
                        providerValue.endDate = snapshot
                            .data?.docs[widget.index]["endDate"]
                            .toDate();
                        providerValue.time =
                            snapshot.data?.docs[widget.index]["time"].toDate();

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: screenSize.height * 0.05,
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
                                    String userId =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    dialogBoxUpdateCurrentMedicineName(
                                        context, userId, widget.id);
                                  },
                                  icon: const Icon(
                                    Icons.medication_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            providerValue.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
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
                                    String userId =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    dialogBoxUpdateCurrentMedicineDescription(
                                        context, userId, widget.id);
                                  },
                                  icon: const Icon(
                                    Icons.description,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            providerValue.description,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
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
                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text(
                                          "Add Dosage",
                                          style: TextStyle(),
                                        ),
                                        content: Numbersdemo(
                                            initialvalue: providerValue.dosage,
                                            min: 0,
                                            max: 4,
                                            step: 1,
                                            onchanged: (value) {
                                              providerValue.getDosage(value);
                                              providerValue.medication = {
                                                "dosage": providerValue.dosage,
                                              };
                                            }),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(userId)
                                                  .collection("medications")
                                                  .doc(widget.id)
                                                  .update(
                                                      providerValue.medication);

                                              Navigator.pop(context);
                                            },
                                            child: const Text("Save"),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Dosage - ${providerValue.dosage}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
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
                                  onPressed: () async {
                                    final DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2028),
                                    );

                                    if (date != null) {
                                      providerValue.getStartDate(date);
                                      providerValue.medication = {
                                        "startDate": providerValue.startDate,
                                      };
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(userId)
                                          .collection("medications")
                                          .doc(widget.id)
                                          .update(providerValue.medication);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Start - ${DateFormat(
                                              "dd/MM/yyyy",
                                            ).format(providerValue.startDate!)}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
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
                                  onPressed: () async {
                                    final DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2028),
                                    );

                                    if (date != null) {
                                      providerValue.getEndDate(date);
                                      providerValue.medication = {
                                        "endDate": providerValue.endDate,
                                      };
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(userId)
                                          .collection("medications")
                                          .doc(widget.id)
                                          .update(providerValue.medication);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "time - ${DateFormat(
                                              "dd/MM/yyyy",
                                            ).format(providerValue.endDate!)}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
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
                                  onPressed: () async {
                                    TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );

                                    if (time != null) {
                                      DateTime dtime = DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day,
                                        time.hour,
                                        time.minute,
                                      );
                                      providerValue.getTime(dtime);
                                      providerValue.medication = {
                                        "time": providerValue.time,
                                      };
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(userId)
                                          .collection("medications")
                                          .doc(widget.id)
                                          .update(providerValue.medication);
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  label: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Time - ${DateFormat(
                                              "hh:mm",
                                            ).format(providerValue.time!)}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 25,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height * 0.05,
                              ),
                              SizedBox(
                                height: 50,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    providerValue.clearAll();
                                    Navigator.pop(context);
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
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
