import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pathstrides_mobile/Screens/geolocation_screen.dart';
import 'package:pathstrides_mobile/Screens/landing_screen.dart';
import 'package:pathstrides_mobile/Screens/location_page.dart';
import 'package:pathstrides_mobile/Screens/pointsshop_screen.dart';
import 'package:pathstrides_mobile/Screens/task_report.dart';
import '../Screens/register_screen.dart';
import 'Screens/announcement_screen.dart';
import 'Screens/dashboard_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/profile_screen.dart';
import 'Screens/task_desc.dart';
import 'Screens/task_screen.dart';
import 'Screens/taskReport_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
