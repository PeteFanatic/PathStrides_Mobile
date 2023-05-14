import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pathstrides_mobile/Screens/landing_screen.dart';
import 'package:pathstrides_mobile/Services/profile_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),
    );
  }
}
