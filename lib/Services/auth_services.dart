import 'dart:convert';

import 'package:pathstrides_mobile/Services/globals.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  var token;
  static Future<http.Response> register(
      String oldPass, String newPass, String confirmPass) async {
    Map data = {
      "oldPass": oldPass,
      "newPass": newPass,
      "confirmPass": confirmPass,
    };
    var body = json.encode(data);
    // ignore: prefer_interpolation_to_compose_strings
    var url = Uri.parse(baseURL + 'auth/updateEmployeePass');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
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

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   //token = jsonDecode(localStorage.getString('users'))['user_id'];
  // }

  // authData(data, apiUrl) async {
  //   var fullUrl = Uri.parse(baseURL + 'auth/loginEmployee');
  //   return await http.post(fullUrl,
  //       body: jsonEncode(data), headers: _setHeaders());
  // }

  // _setHeaders() => {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     };
}
