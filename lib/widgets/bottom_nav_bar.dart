import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: GNav(
          gap: 8,
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 255, 153, 0),
          activeColor: Color.fromARGB(255, 255, 153, 0),
          tabBackgroundColor: Color.fromARGB(69, 255, 153, 0),
          tabs: const [
            GButton(
              icon: Icons.home,
            ),
            GButton(icon: Icons.announcement),
            GButton(icon: Icons.list),
            GButton(icon: Icons.notifications),
            GButton(icon: Icons.person),
          ],
        ),
      ),
    );
  }
}
