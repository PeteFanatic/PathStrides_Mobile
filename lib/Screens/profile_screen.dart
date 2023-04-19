import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:pathstrides_mobile/Screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/user.dart';

class ProfileScreen extends StatefulWidget {
  //ProfileData profileview;
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences preferences;
  @override
  void initState() {
    super.initState;
    getUserData();
  }

  void getUserData() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // var user = UserData();
    String f_name = preferences.getString('user_fname').toString();
    String m_name = preferences.getString('user_mname').toString();
    if (m_name == null) {
      m_name = "";
    }
    String l_name = preferences.getString('user_lname').toString();
    String username = preferences.getString('user_username').toString();
    String email = preferences.getString('user_email').toString();
    String department = preferences.getString('user_department').toString();
    String status = preferences.getString('status').toString();
    String contactnumber = preferences.getString('contactnumber').toString();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.10, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            color: Color.fromARGB(255, 255, 255, 255), // set your color
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Color.fromARGB(255, 255, 153, 0),
                          ),
                        ),
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
      body: Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 157, 59),
                Color.fromARGB(255, 235, 80, 24),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.person_pin_circle_rounded),
                              onPressed: () {},
                              iconSize: 150,
                            ),
                          ],
                        ),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${f_name} ${m_name} ${l_name}',
                                    style: TextStyle(
                                      fontFamily: 'Inter-Bold',
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              new BorderRadius.circular(16.0),
                                          color: Colors.green,
                                        ),
                                        child: Text(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.only(
                bottom: 15,
                left: 10,
                top: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.person_2_rounded),
                        onPressed: () {},
                        iconSize: 30,
                      ),
                      Text(
                        username == null ? "" : username,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.groups_3_rounded),
                        onPressed: () {},
                        iconSize: 30,
                      ),
                      Text(
                        department == null ? "" : department,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.email_rounded),
                        onPressed: () {},
                        iconSize: 30,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.phone_android_rounded),
                        onPressed: () {},
                        iconSize: 30,
                      ),
                      Text(
                        contactnumber != null ? "" : contactnumber,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                        ),
                      ),
                    ],
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
