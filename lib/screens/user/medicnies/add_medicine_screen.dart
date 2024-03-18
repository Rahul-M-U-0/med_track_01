import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_track_01/providers/userProviders/medication_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class UserAddMedicineScreen extends StatefulWidget {
  const UserAddMedicineScreen({
    super.key,
    this.leadback = false,
  });
  final bool leadback;
  @override
  State<UserAddMedicineScreen> createState() => _UserAddMedicineScreenState();
}

class _UserAddMedicineScreenState extends State<UserAddMedicineScreen> {
  bool _isExpanded = false;

  final List<String> items = [
    "Pill",
    "Solution(Liquid)",
    "Drops",
    "Inhaler",
    "Powder",
    "Tablet",
    "Antibiotics",
    "Antiseptic",
  ];
  final _startingDateController = TextEditingController();
  final _endingDateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void dispose() {
    _startingDateController.dispose();
    _endingDateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void submitAddButton(
      UserCreateMedicineProvider providerValue, BuildContext context) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    String id = randomAlphaNumeric(10);

    if (providerValue.name != "" &&
        providerValue.description != "" &&
        providerValue.dosage != 0 &&
        providerValue.type != null &&
        providerValue.startDate != null &&
        providerValue.endDate != null &&
        providerValue.time != null) {
      providerValue.setDataToMap(id);

      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("medications")
          .doc(id)
          .set(providerValue.medication)
          .then((value) {
        if (widget.leadback) {
          Navigator.pop(context);
        }
      });
      providerValue.clearAll();
    } else {
      showErrorMessage("Fill all field");
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff04516f),
        appBar: AppBar(
          backgroundColor: const Color(0xff04516f),
          leading: Consumer<UserCreateMedicineProvider>(
            builder: (context, providerValue, child) {
              return widget.leadback
                  ? IconButton(
                      onPressed: () {
                        providerValue.clearAll();
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    )
                  : const Text("");
            },
          ),
          title: const Text(
            "Add Medicine",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Consumer<UserCreateMedicineProvider>(
              builder: (context, providerValue, child) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),

                    // start
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          cardColor: const Color(0xff04516f),
                        ),
                        child: ExpansionPanelList(
                          expandIconColor: Colors.white,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              isExpanded: _isExpanded,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return const ListTile(
                                  title: Text(
                                    "Medication",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              },
                              body: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.transparent),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      onChanged: (value) {
                                        providerValue.getName(value);
                                      },
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                        labelText: "Medicine Name",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    TextFormField(
                                      onChanged: (value) {
                                        providerValue.getDescription(value);
                                      },
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      decoration: const InputDecoration(
                                        labelText: "Description",
                                        labelStyle:
                                            TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: OutlinedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0),
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
                                  }),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              providerValue.dosage == 0
                                  ? "Add Dosage"
                                  : providerValue.dosage
                                      .toString(), // value ? value : days
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                        iconDisabledColor: const Color(0xff15c79a),
                        iconEnabledColor: const Color(0xff15c79a),
                        dropdownColor: const Color(0xff04516f),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff15c79a),
                            ),
                          ),
                        ),
                        hint: providerValue.type == null
                            ? const Text(
                                "Medicine Type",
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                "${providerValue.type}",
                                style: const TextStyle(color: Colors.white),
                              ),
                        value: providerValue.type,
                        items: items
                            .map(
                              (menu) => DropdownMenuItem(
                                value: menu,
                                child: Text(
                                  menu,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (menu) {
                          providerValue.getType(menu);
                        }),

                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Set Reminders",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _startingDateController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff15c79a),
                          ),
                        ),
                        hintText: "Starting Date",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2028));
                            final formatteddate = DateFormat(
                              "dd-MM-yyyy",
                            ).format(date!);
                            setState(() {
                              _startingDateController.text = formatteddate;
                            });
                            providerValue.getStartDate(date);
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Color(0xff15c79a),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: _endingDateController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff15c79a),
                          ),
                        ),
                        hintText: "Ending Date",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            final DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2028));
                            final formatteddate = DateFormat(
                              "dd-MM-yyyy",
                            ).format(date!);
                            setState(() {
                              _endingDateController.text = formatteddate;
                            });
                            providerValue.getEndDate(date);
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Color(0xff15c79a),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff15c79a),
                          ),
                        ),
                        hintText: "Time",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            setState(() {
                              if (time != null) {
                                _timeController.text = time.format(context);
                                DateTime dtime = DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  time.hour,
                                  time.minute,
                                );
                                providerValue.getTime(dtime);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.access_time_rounded,
                            size: 27,
                            color: Color(0xff15c79a),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff15c79a),
                        ),
                        onPressed: () {
                          submitAddButton(providerValue, context);
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//Numbers demo
class Numbersdemo extends StatefulWidget {
  final int initialvalue;
  final int min;
  final int max;
  final int step;
  final Function(int) onchanged;

  const Numbersdemo(
      {super.key,
      required this.initialvalue,
      required this.min,
      required this.max,
      required this.step,
      required this.onchanged});

  @override
  State<Numbersdemo> createState() => _NumbersdemoState();
}

class _NumbersdemoState extends State<Numbersdemo> {
  int _currentvalue = 0;
  @override
  void initState() {
    super.initState();
    _currentvalue = widget.initialvalue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (_currentvalue > widget.min) {
                _currentvalue -= widget.step;
              }
              widget.onchanged(_currentvalue);
            });
          },
          icon: const Icon(Icons.remove_circle),
        ),
        Text(
          _currentvalue.toString(),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (_currentvalue < widget.max) {
                _currentvalue += widget.step;
              }
              widget.onchanged(_currentvalue);
            });
          },
          icon: const Icon(Icons.add_circle),
        ),
      ],
    );
  }
}
