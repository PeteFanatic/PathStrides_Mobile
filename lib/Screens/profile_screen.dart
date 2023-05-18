// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Screens/login_screen.dart';
import 'package:pathstrides_mobile/Screens/pointsshop_screen.dart';
import 'package:pathstrides_mobile/Services/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/globals.dart';
import '../controller/pointshop_controller.dart';

class ProfileScreen extends StatefulWidget {
  //ProfileData profileview;
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //UserProfileModel user = userProfile.value;
    final token = preferences.getString('token');
    // Retrieve the user's token from the shared preferences or any other storage mechanism

    final response = await http.post(
      Uri.parse('https://10.0.2.2:8000/api/logoutEmployee'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Logout successful
      // Clear user data and navigate to the login screen
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen(),
          ));
      // Navigate to login screen
    } else {
      errorSnackBar(context, 'logout error.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // var user = UserData();
    final controller = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70.10, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            color: const Color.fromARGB(255, 255, 255, 255), // set your color
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "User Profile",
                          style: TextStyle(
                            fontFamily: 'Inter-Black',
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 157, 59),
                  Color.fromARGB(255, 235, 80, 24),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.person_pin_circle_rounded),
                                onPressed: () {},
                                iconSize: 150,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(
                                    () {
                                      UserProfileModel user =
                                          controller.userProfile.value;
                                      return Text(
                                        '${user.firstName ?? ""} ${user.middleName ?? ""} ${user.lastName ?? ""}',
                                        style: const TextStyle(
                                          fontFamily: 'Inter-Bold',
                                          fontSize: 30,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          color: Colors.green,
                                        ),
                                        child: const Text(
                                          "Present",
                                          style: TextStyle(
                                            fontFamily: 'Inter-Bold',
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column()
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(
                  bottom: 15,
                  left: 10,
                  top: 15,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.person_2_rounded),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                        Obx(() {
                          UserProfileModel user = controller.userProfile.value;
                          return Text(
                            user.userName ?? "",
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                            ),
                          );
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.email_rounded),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                        Obx(() {
                          UserProfileModel user = controller.userProfile.value;
                          return Text(
                            user.email ?? "",
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                            ),
                          );
                        }),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.phone_android_rounded),
                          onPressed: () {},
                          iconSize: 30,
                        ),
                        Obx(() {
                          UserProfileModel user = controller.userProfile.value;
                          return Text(
                            user.contactNumber ?? "",
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.put(PointShopController());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PointsShopScreen()));
                },

                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
                    minimumSize: const Size(150, 40),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 255, 153, 0),
                    elevation: 12.0,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter-Bold',
                        fontSize: 18)),
                child: const Text('Points Shop'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  if (mounted) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  }
                },
                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
                    minimumSize: const Size(150, 40),
                    backgroundColor: const Color.fromARGB(255, 71, 71, 71),
                    elevation: 12.0,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter-Bold',
                        fontSize: 18)),
                child: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
