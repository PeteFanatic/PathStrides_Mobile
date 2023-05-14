// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Services/getX.dart';
import 'package:pathstrides_mobile/Services/navBar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavBarController());
    return Scaffold(
      // tabBar: CupertinoTabBar(
      //   height: 50,
      //   activeColor: const Color.fromARGB(255, 255, 126, 45),
      //   inactiveColor: Color.fromARGB(255, 20, 20, 20),
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         size: 30,
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.system_security_update_warning),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.assignment),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person_rounded),
      //       label: '',
      //     ),
      //   ],
      // ),
      // tabBuilder: (context, index) {
      //   switch (index) {
      //     case 0:
      //       return CupertinoTabView(builder: (context) {
      //         return CupertinoPageScaffold(
      //           child: HomeScreen(),
      //         );
      //       });
      //     case 1:
      //       return CupertinoTabView(builder: (context) {
      //         return CupertinoPageScaffold(
      //           child: AnnouncementScreen(),
      //         );
      //       });
      //     case 2:
      //       return CupertinoTabView(builder: (context) {
      //         return CupertinoPageScaffold(
      //           child: TaskScreen(),
      //         );
      //       });

      //     default:
      //       return CupertinoTabView(builder: (context) {
      //         return CupertinoPageScaffold(
      //           child: ProfileScreen(),
      //         );
      //       });
      //   }
      // },
      body: SafeArea(
        child: Obx(() => controller.currentScreenModel),
      ),
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          items: controller.navItems,
          onTap: controller.tabIndex,
          currentIndex: controller.tabIndex(),
        ),
      ),
    );
  }
}
