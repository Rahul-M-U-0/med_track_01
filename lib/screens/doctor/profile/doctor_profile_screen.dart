import 'package:flutter/material.dart';
import 'package:med_track_01/screens/getstarted_screen.dart';

class DoctorProfilePage extends StatelessWidget {
  DoctorProfilePage({super.key});

  final String name = 'Dr Hari';
  final String licenseid = 'ADR16767AS2';
  final String email = 'hari@gmail.com';
  final String phoneno = '123456789';

  final String profileImage = 'assets/images/Doctors.png';

  void changePassword(BuildContext context) {}

  void editProfile(BuildContext context) {}

  final nameController = TextEditingController();
  final licensecontroller = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailIDController = TextEditingController();

  void submitProfile(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff04516f),
        appBar: AppBar(
          backgroundColor: const Color(0xff04516f),
          title: const Text(
            'Doctor Profile',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: screenSize.width * 0.20,
                backgroundColor: const Color(0xff15c79a),
                child: CircleAvatar(
                  radius: screenSize.width * 0.25 - 2,
                  backgroundImage: AssetImage(profileImage),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffffffff),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    licenseid,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffffffff),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                      const Text('   |   '),
                      Text(
                        phoneno,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    editProfile(context);
                  },
                  child: const Text(
                    "Edit profile",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: screenSize.height * 0.08,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            changePassword(context);
                          },
                          icon: const Icon(
                            Icons.key,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 30,
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
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const GetStartedScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 30,
                            color: Colors.white,
                          ),
                          label: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Log Out",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 30,
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
                              backgroundColor: Colors.transparent),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ),
                          label: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Delete Account",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 30,
                                color: Colors.red,
                              ),
                            ],
                          ),
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
    );
  }
}
