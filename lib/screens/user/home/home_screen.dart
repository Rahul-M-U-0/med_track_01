import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_timeline_calendar/timeline/utils/datetime_extension.dart';
import 'package:intl/intl.dart';
import 'package:med_track_01/providers/userProviders/medication_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDateBetween(DateTime date, DateTime startDate, DateTime endDate) {
    return date.isAfterOrEqualTo(startDate)! &&
        date.isBeforeOrEqualTo(endDate)!;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var firestore = FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("medications")
        .snapshots();
    var userFirestore =
        FirebaseFirestore.instance.collection("users").doc(userId).snapshots();

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenSize.height * 0.4,
                color: const Color(0xff04516f),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenSize.height * 0.08,
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Hello,",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 1,
                              ),
                              StreamBuilder(
                                stream: userFirestore,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    String name = snapshot.data!["name"];
                                    return Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    );
                                  } else {
                                    return const Text("");
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: screenSize.height * 0.25,
                                width: screenSize.height * 0.25,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(0, 255, 193, 7),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/medicine.png"),
                                    scale: 1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<UserCreateMedicineProvider>(
                builder: (context, providerValue, child) {
                  return Positioned(
                    top: screenSize.height * 0.28,
                    child: Container(
                      height: screenSize.height * 0.9,
                      width: screenSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: screenSize.height * 0.12,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              color: Colors.white,
                            ),
                            child: DatePicker(
                              DateTime.now(),
                              height: 100,
                              width: 60,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: const Color(0xff15c79a),
                              onDateChange: (selectedDate) {
                                providerValue.getCurrentDate(selectedDate);
                              },
                              dateTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                            stream: firestore,
                            builder: (context, snapshot) {
                              if ((snapshot.data?.docs.length).toString() ==
                                      "null" ||
                                  (snapshot.data?.docs.length).toString() ==
                                      "0") {
                                return Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(0, 255, 255, 255),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "assets/images/clock.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "No Reminder added",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox(
                                  width: double.infinity,
                                  height: screenSize.height * 0.5,
                                  child: Consumer<UserCreateMedicineProvider>(
                                    builder: (context, providerValue, child) {
                                      int count = snapshot.data!.size;

                                      return ListView.builder(
                                        itemCount: count,
                                        itemBuilder: (context, index) {
                                          String name = snapshot
                                              .data!.docs[index]["name"];
                                          String description = snapshot
                                              .data!.docs[index]["description"];

                                          int dosage = snapshot
                                              .data!.docs[index]["dosage"];
                                          DateTime startDate = snapshot
                                              .data!.docs[index]["startDate"]
                                              .toDate();
                                          DateTime endDate = snapshot
                                              .data!.docs[index]["endDate"]
                                              .toDate();

                                          if (isDateBetween(
                                              providerValue.currentDate,
                                              startDate,
                                              endDate)) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 25,
                                                vertical: 5,
                                              ),
                                              child: Slidable(
                                                endActionPane: ActionPane(
                                                  motion: const StretchMotion(),
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: ((context) {}),
                                                      backgroundColor:
                                                          Colors.grey.shade100,
                                                      icon: Icons.check,
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff04516f),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ListTile(
                                                    tileColor:
                                                        const Color(0xff04516f),
                                                    trailing: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "Dosage - $dosage",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                            "dd/MM/yyyy",
                                                          ).format(providerValue
                                                              .currentDate),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    leading: CircleAvatar(
                                                      radius: 22,
                                                      backgroundColor:
                                                          Colors.white60,
                                                      child: Image.asset(
                                                        "assets/images/pillspng.png",
                                                      ),
                                                    ),
                                                    title: Text(
                                                      name,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      description,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return const SizedBox(
                                              height: 0,
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
