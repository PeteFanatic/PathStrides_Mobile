// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Screens/register_screen.dart';
import 'package:pathstrides_mobile/Services/auth_services.dart';

import 'package:pathstrides_mobile/Services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:pathstrides_mobile/Services/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

//import '../Services/task_api.dart';
import '../rounded_button.dart';
import 'dashboard_screen.dart';
//import 'home_screen.dart';
import 'landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

Future<UserData> getUser() async {
  var data = await http.get(Uri.parse('http://10.0.2.2:8000/api/employeeUser'));
  var jsonData = json.decode(data.body);
  late SharedPreferences preferences;
  preferences = await SharedPreferences.getInstance();
  var u = jsonData;
  UserData user = u["user_id"];
  u["user_fname"];
  u["user_mname"];
  u["user_lname"];
  u["user_email"];
  u["contactnumber"];
  u["user_username"];
  u["user_password"];
  u["user_department"];
  u["role"];
  u["status"];
  u["admin_id"];
  u["dep_id"];
  return user;
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';
  bool ishiddenPassword = true;

  bool _isLoading = false;

  // TextEditingController mailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  ScaffoldState scaffoldState = ScaffoldState();
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  loginPressed() async {
    if (_email.isNotEmpty && _password.isNotEmpty) {
      http.Response response = await AuthServices.login(_email, _password);
      final responseMap = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // final loginUser =
        //     await context.read<UserData>().login(_email, _password);
        // if (loginUser != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setInt('user_id', responseMap['users']['user_id']);
        await preferences.setInt(
            'user_points', responseMap['users']['user_points']);
        await preferences.setString(
            'user_fname', responseMap['users']['user_fname']);
        await preferences.setString(
            'user_mname', responseMap['users']['user_mname']);
        await preferences.setString(
            'user_lname', responseMap['users']['user_lname']);
        await preferences.setString(
            'user_email', responseMap['users']['user_email']);
        await preferences.setString(
            'user_username', responseMap['users']['user_username']);
        await preferences.setString(
            'user_department', responseMap['users']['user_department']);
        await preferences.setString('token', 'token');
        return Future.delayed(
            const Duration(seconds: 1),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const DashboardScreen(),
                )));
        // }
      } else if (response.statusCode == 201) {
        //SharedPreferences localStorage = await SharedPreferences.getInstance();
        //var token = localStorage.setString('token', _password);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const RegisterScreen(),
            ));
      } else if (response.statusCode == 400) {
        errorSnackBar(context, responseMap.values.first);
      }
    } else {
      errorSnackBar(context, 'enter all required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UserData(),
        child: Scaffold(
            body: Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LandingScreen()));
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
              padding: const EdgeInsets.only(
                  top: 30.0, left: 0.0, bottom: 0.0, right: 0.0),
              height: 180,
              width: double.infinity,
              child: Image.asset(
                "assets/images/pathstrides-logo-with-text.png",
                width: 100,
                height: 100,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 255, 126, 45),
                    ),
                  ),
                ),
                onChanged: (value) {
                  _email = value;
                },
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter-SemiBold',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextField(
                obscureText: ishiddenPassword,
                decoration: InputDecoration(
                    hintText: 'Enter password',
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
                  _password = value;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            RoundedButton(
              btnText: 'Log In',
              onBtnPressed: () => loginPressed(),
            )
          ],
        )));
  }
}
