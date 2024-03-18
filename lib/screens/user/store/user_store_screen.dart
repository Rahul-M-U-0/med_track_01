import 'package:flutter/material.dart';

class UserStoreScreen extends StatelessWidget {
  const UserStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Store Page",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
