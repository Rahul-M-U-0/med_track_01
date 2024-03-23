import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med_track_01/providers/userProviders/user_profile_provider.dart';
import 'package:med_track_01/screens/user/chat/user_chat_screen.dart';
import 'package:med_track_01/screens/user/home/home_screen.dart';
import 'package:med_track_01/screens/user/medicnies/user_medications.dart';
import 'package:med_track_01/screens/user/profile/user_profile_screen.dart';
import 'package:med_track_01/screens/user/store/user_store_screen.dart';
import 'package:med_track_01/screens/user/widgets/get_profile.dart';
import 'package:provider/provider.dart';

class UserBottomNavi extends StatefulWidget {
  const UserBottomNavi({super.key});

  @override
  State<UserBottomNavi> createState() => _UserBottomNaviState();
}

class _UserBottomNaviState extends State<UserBottomNavi> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of(
    [
      TabItem(
        Icons.home,
        "Home",
        const Color(0xff04516f),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      TabItem(
        FontAwesomeIcons.pills,
        "Medicines",
        const Color(0xff04516f),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      TabItem(
        Icons.store_sharp,
        "Store",
        const Color(0xff04516f),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      TabItem(
        Icons.message,
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
    const HomeScreen(),
    const UserMedicationScreen(),
    const UserStoreScreen(),
    const UserChatScreen(),
    const UserProfileScreen(),
  ];

  @override
  void initState() {
    final profileProvider =
        Provider.of<UserProfileProvider>(context, listen: false);
    getUserProfileInfo(profileProvider);
    _navigationController = CircularBottomNavigationController(selectedPos);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: bottomNavBarHeight),
            child: _pages[selectedPos],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: isKeyBoardOpen ? null : bottomNav(),
          ),
        ],
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
