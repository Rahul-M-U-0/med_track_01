import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';

getProfileInfo(UserProfileProvider providerValue) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  var fireAuth =
      FirebaseFirestore.instance.collection("users").doc(userId).get();
  fireAuth.then(
    (value1) => value1.data()?.forEach(
      (key, value) {
        if (key == "name") {
          providerValue.getUserName(value);
        } else if (key == "email") {
          providerValue.getEmail(value);
        } else if (key == "phone") {
          providerValue.getUserPhone(value);
        } else if (key == "address") {
          providerValue.getAddress(value);
        } else if (key == "pic") {
          providerValue.getPic(value);
        }
      },
    ),
  );
}
