import 'package:flutter/material.dart';
import 'package:med_track_01/screens/doctor/auth/doctor_login_or_register_screen.dart';
import 'package:med_track_01/screens/shop/auth/shop_login_or_register_screen.dart';
import 'package:med_track_01/screens/user/auth/user_login_or_register_screen.dart';
import 'package:med_track_01/screens/user/widgets/pageview_items.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late PageController _pageController;
  int _activePage = 0;

  List<Widget> pages = [
    const PageViewItem(
      itemImage: 'assets/images/user.webp',
      title: 'LogIn As User.',
      description: 'Never forget to take your medicines on time.',
      backGround: PageViewBackgroundItem1(),
      txtColor: Colors.black,
    ),
    const PageViewItem(
      itemImage: 'assets/images/Doctors.png',
      title: 'LogIn As Doctor.',
      description: '',
      backGround: PageViewBackgroundItem2(),
      txtColor: Colors.white,
    ),
    const PageViewItem(
      itemImage: 'assets/images/shop.webp',
      title: 'LogIn As Shopkeeper',
      description: 'Sell your medicines .',
      backGround: PageViewBackgroundItem3(),
      txtColor: Colors.white,
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 45,
          width: 45,
          child: FloatingActionButton(
            onPressed: () {
              if (_activePage == pages.length - 1) {
                _pageController.animateToPage(
                  0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutQuart,
                );
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutQuart,
                );
              }
            },
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff15c79a),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      pages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: _activePage == index
                              ? const Color(0xff15c79a)
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 45,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_activePage == 0) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UserLoginOrRegisterScreen(),
                            ),
                          );
                        } else if (_activePage == 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DoctorLoginOrRegisterScreen(),
                            ),
                          );
                        } else if (_activePage == 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ShopLoginOrRegistrationScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff15c79a),
                      ),
                      child: _activePage == 3
                          ? const Text(
                              'LogIn',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              'LogIn/SignUp',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
