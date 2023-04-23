import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pathstrides_mobile/Screens/announcement_screen.dart';
import 'package:pathstrides_mobile/Screens/home_screen.dart';
import 'package:pathstrides_mobile/Screens/pointshop_info.dart';
import 'package:pathstrides_mobile/Screens/pointsshop_screen.dart';
import 'package:pathstrides_mobile/Screens/profile_screen.dart';
import 'package:pathstrides_mobile/Screens/task_screen.dart';

import '../Screens/notification_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  List pages = [
    AnnouncementScreen(),
    TaskScreen(),
    HomeScreen(),
    NotificationScreen(),
    PointsShopScreen(),
  ];
  int currentIndex = 2;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Color.fromARGB(255, 255, 153, 0),
        unselectedItemColor: Color.fromARGB(255, 171, 171, 171),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              label: 'Announcements', icon: Icon(Icons.announcement)),
          BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.list)),
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: 'Notifications', icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
