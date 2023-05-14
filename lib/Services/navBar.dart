import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    this.currentIndex = 0,
    this.onTap,
    required this.items,
  }) : super(key: key);
  final int currentIndex;
  final void Function(int)? onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 255, 126, 45),
      unselectedItemColor: const Color(0xff8C8A8A),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      iconSize: 32.0,
      elevation: 0.0,
      items: items,
    );
  }
}
