import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pathstrides_mobile/Services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserData extends ChangeNotifier {
  int? user_id;
  String? user_fname;
  String? user_mname;
  String? user_lname;
  String? user_email;
  String? contactnumber;
  String? user_username;
  String? user_password;
  String? user_department;
  int? role = 0;
  int? status = 0;
  int? admin_id = 0;
  int? dep_id = 0;

  UserData(
      {this.user_id,
      this.user_fname,
      this.user_mname,
      this.user_lname,
      this.user_email,
      this.contactnumber,
      this.user_username,
      this.user_password,
      this.user_department,
      this.role,
      this.status,
      this.admin_id,
      this.dep_id});

  factory UserData.fromJson(Map<String, dynamic> item) {
    return UserData(
      user_id: item['user_id'],
      user_fname: item['user_fname'],
      user_mname: item['user_mname'],
      user_lname: item['user_lname'],
      user_email: item['user_email'],
      contactnumber: item['contactnumber'],
      user_username: item['user_username'],
      user_password: item['user_password'],
      user_department: item['user_department'],
      role: item['role'],
      status: item['status'],
      admin_id: item['admin_id'],
      dep_id: item['dep_id'],
    );
  }
  Map<String, dynamic> toMap() => {
        "user_id": user_id,
        "user_fname": user_fname,
        "user_mname": user_mname,
        "user_lname": user_lname,
        "user_email": user_email,
        "contactnumber": contactnumber,
        "user_username": user_username,
        "user_password": user_password,
        "user_department": user_department,
        "role": role,
        "status": status,
      };

  Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = json.encode(data);
    // ignore: prefer_interpolation_to_compose_strings
    var url = Uri.parse(baseURL + 'auth/loginEmployee');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    return response;
  }
}
