import 'package:flutter/material.dart';

class UserChatScreen extends StatelessWidget {
  const UserChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Chat screen",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
