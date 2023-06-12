import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/pointshopdata_model.dart';

class PointShopController extends GetxController {
  final pointshopdatas = <PointShopData>[].obs;

  Future<void> getRedeemShop() async {
    var data3 =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/employeePointShop'));
    var jsonData = json.decode(data3.body);
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    int? user_id = preferences.getInt('user_id');
    List<PointShopData> pointShops = [];
    for (var p in jsonData) {
      print(
          "Item ID: $p['item_id'] Item Name: $p['item_name'] Points: $p['points'] Item Code: $p['item_code'] User ID: $p['user_id']");
      PointShopData pointShop = PointShopData(
          p["item_id"],
          p["item_name"],
          p["points"],
          p["item_code"],
          p["user_id"],
          p['isSold'] == 1 ? true : false,
          p['isClaimed'] == 1 ? true : false);
      int temp = p["user_id"];

      if (p['isClaimed'] != 1) {
        pointShops.add(pointShop);
      }
    }
    print(pointShops.length);
    pointshopdatas.value = pointShops;
  }

  Future<void> setItemAsSold(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString('token')!;

    Map<String, dynamic> parameters = {
      'id': pointshopdatas[index].item_id.toString(),
      'isSold': '1',
    };

    print(token);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    await http.post(
        Uri.parse('http://10.0.2.2:8000/api/sold')
            .replace(queryParameters: parameters),
        headers: headers);
    getRedeemShop();
    pointshopdatas[index].isSold = true;
  }

  Future<void> setItemAsClaimed(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String token = preferences.getString('token')!;

    Map<String, dynamic> parameters = {
      'id': pointshopdatas[index].item_id.toString(),
      'isClaimed': '1',
    };

    print(token);

    Map<String, String> headers = {'Authorization': 'Bearer $token'};

    await http.post(
        Uri.parse('http://10.0.2.2:8000/api/claimed')
            .replace(queryParameters: parameters),
        headers: headers);
    getRedeemShop();
    pointshopdatas[index].isClaimed = true;
  }

  @override
  void onInit() {
    getRedeemShop();
    super.onInit();
  }
}
