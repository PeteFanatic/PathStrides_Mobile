// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Screens/announcement_screen.dart';
import 'package:pathstrides_mobile/Screens/home_screen.dart';
import 'package:pathstrides_mobile/Screens/profile_screen.dart';
import 'package:pathstrides_mobile/Screens/task_screen.dart';

class NavBarController extends GetxController {
  final tabIndex = 0.obs;
  final navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.system_security_update_warning),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: '',
    ),
  ];
  final screens = <Widget>[
    HomeScreen(),
    AnnouncementScreen(),
    TaskScreen(),
    ProfileScreen()
  ];
  Widget get currentScreenModel => screens[tabIndex.value];
}
