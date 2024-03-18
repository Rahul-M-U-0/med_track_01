import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/providers/userProviders/medication_provider.dart';
import 'package:provider/provider.dart';

dialogBoxUpdateCurrentMedicineName(context, userId, id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          "Medicine Name",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.infinity,
          child: Consumer<UserCreateMedicineProvider>(
            builder: (context, providerValue, child) {
              return TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: providerValue.name,
                onChanged: (value) {
                  providerValue.getName(value);
                  providerValue.medication = {
                    "name": providerValue.name,
                  };
                },
              );
            },
          ),
        ),
        actions: [
          Consumer<UserCreateMedicineProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              );
            },
          ),
          Consumer<UserCreateMedicineProvider>(
            builder: (context, providerValue, child) {
              return ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(userId)
                      .collection("medications")
                      .doc(id)
                      .update(providerValue.medication);

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

dialogBoxUpdateCurrentMedicineDescription(context, userId, id) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          "Medicine Description",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.infinity,
          child: Consumer<UserCreateMedicineProvider>(
            builder: (context, providerValue, child) {
              return TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                initialValue: providerValue.description,
                onChanged: (value) {
                  providerValue.getDescription(value);
                  providerValue.medication = {
                    "description": providerValue.description,
                  };
                },
              );
            },
          ),
        ),
        actions: [
          Consumer<UserCreateMedicineProvider>(
            builder: (context, profileProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              );
            },
          ),
          Consumer<UserCreateMedicineProvider>(
            builder: (context, providerValue, child) {
              return ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(userId)
                      .collection("medications")
                      .doc(id)
                      .update(providerValue.medication);

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
