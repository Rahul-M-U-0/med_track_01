import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:med_track_01/screens/doctor/chat/doctor_chat_screen.dart';
import 'package:med_track_01/screens/doctor/profile/doctor_profile_screen.dart';

class DoctorBottomNavi extends StatefulWidget {
  const DoctorBottomNavi({super.key});

  @override
  State<DoctorBottomNavi> createState() => _DoctorBottomNaviState();
}

class _DoctorBottomNaviState extends State<DoctorBottomNavi> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;
  List<TabItem> tabItems = List.of(
    [
      TabItem(
        Icons.chat,
        "Chat",
        const Color(0xff04516f),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      TabItem(
        Icons.person,
        "Profile",
        const Color(0xff04516f),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    ],
  );

  late CircularBottomNavigationController _navigationController;
  final List<Widget> _pages = [
    const DoctorChatScreen(),
    DoctorProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: bottomNavBarHeight),
              child: _pages[selectedPos],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: bottomNav(),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: const <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: const Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }
}
