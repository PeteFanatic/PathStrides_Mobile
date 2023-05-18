import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Screens/dashboard_screen.dart';
import 'package:pathstrides_mobile/Services/auth_services.dart';
import 'package:pathstrides_mobile/Services/globals.dart';
import 'package:pathstrides_mobile/Services/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import '../rounded_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _oldPass = '';
  String _newPass = '';
  String _confirmPass = '';
  bool ishiddenPassword = true;

  createAccountPressed(ProfileController controller) async {
    // bool emailValid = RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(_email);
    if (_oldPass.isNotEmpty && _newPass.isNotEmpty && _confirmPass.isNotEmpty) {
      http.Response response =
          await AuthServices.register(_oldPass, _newPass, _confirmPass);
      // try {
      final responseMap = jsonDecode(response.body);
      //var token = SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt('user_id', responseMap['users']['user_id']);
        await preferences.setInt(
            'user_points', responseMap['users']['user_points']);
        await preferences.setString(
            'user_fname', responseMap['users']['user_fname']);
        await preferences.setString(
            'user_lname', responseMap['users']['user_lname']);
        await preferences.setString(
            'user_email', responseMap['users']['user_email']);
        await preferences.setString(
            'user_username', responseMap['users']['user_username']);
        await preferences.setString(
            'contactnumber', responseMap['users']['contactnumber']);
        await preferences.setString('status', responseMap['users']['status']);

        await preferences.setInt('admin_id', responseMap['users']['admin_id']);
        await preferences.setString(
            'dep_name', responseMap['users']['dep_name']);
        await preferences.setInt('emp_coll', responseMap['users']['emp_coll']);
        await preferences.setString('token', 'token');
        controller.setUserProfile();
        //await preferences.setStringList('data', responseMap[<String>["users"]]);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const DashboardScreen(),
            ));
      } else if (response.statusCode == 400) {
        //errorSnackBar(context, responseMap.values.first);
        errorSnackBar(context, 'invalid input.');
      }
    } else {
      errorSnackBar(context, 'Incomplete Credentials.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              padding: const EdgeInsets.only(
                  top: 40.0, left: 0.0, bottom: 0.0, right: 330.0),
              icon: const Icon(
                Icons.arrow_circle_left_rounded,
                color: const Color.fromARGB(255, 255, 126, 45),
                size: 40.0,
              ),
            ),
            Container(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(
                  top: 50.0, left: 0.0, bottom: 50.0, right: 0.0),
              child: const Text('Update Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Inter-Black',
                      fontSize: 26.0,
                      letterSpacing: -1.0,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                obscureText: ishiddenPassword,
                decoration: InputDecoration(
                    hintText: 'Current password',
                    // ignore: prefer_const_constructors
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 126, 45),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          ishiddenPassword = !ishiddenPassword;
                        });
                      },
                      child: Icon(
                        ishiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 255, 126, 45),
                      ),
                    )),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter-SemiBold',
                ),
                onChanged: (value) {
                  _oldPass = value;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                obscureText: ishiddenPassword,
                decoration: InputDecoration(
                    hintText: 'New password',
                    // ignore: prefer_const_constructors
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 126, 45),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          ishiddenPassword = !ishiddenPassword;
                        });
                      },
                      child: Icon(
                        ishiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 255, 126, 45),
                      ),
                    )),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter-SemiBold',
                ),
                onChanged: (value) {
                  _newPass = value;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                obscureText: ishiddenPassword,
                decoration: InputDecoration(
                    hintText: 'Confirm password',
                    // ignore: prefer_const_constructors
                    focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 126, 45),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          ishiddenPassword = !ishiddenPassword;
                        });
                      },
                      child: Icon(
                        ishiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 255, 126, 45),
                      ),
                    )),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter-SemiBold',
                ),
                onChanged: (value) {
                  _confirmPass = value;
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundedButton(
              btnText: 'Update',
              onBtnPressed: () => createAccountPressed(controller),
            ),
            const SizedBox(
              height: 40,
            ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (BuildContext context) => const LoginScreen(),
            //         ));
            //   },
            //   child: const Text(
            //     'already have an account? Login Here',
            //     style: TextStyle(
            //       decoration: TextDecoration.underline,
            //       fontSize: 14,
            //       fontFamily: 'Inter-SemiBold',
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
