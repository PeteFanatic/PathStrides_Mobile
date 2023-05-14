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
      PointShopData pointShop = PointShopData(p["item_id"], p["item_name"],
          p["points"], p["item_code"], p["user_id"], false, false);
      int temp = p["user_id"];
      if (temp == user_id || temp == null) {
        pointShops.add(pointShop);
      }
    }
    print(pointShops.length);
    pointshopdatas.value = pointShops;
  }

  void setItemAsSold(int index) {
    pointshopdatas[index].isSold = true;
  }

  void setItemAsClaimed(int index) {
    pointshopdatas[index].isClaimed = true;
  }

  @override
  void onInit() {
    getRedeemShop();
    super.onInit();
  }
}
