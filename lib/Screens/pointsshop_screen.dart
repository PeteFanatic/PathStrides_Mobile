import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pathstrides_mobile/Screens/pointshop_info.dart';
import 'package:pathstrides_mobile/controller/pointshop_controller.dart';
import 'package:pathstrides_mobile/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:pathstrides_mobile/widgets/ItemsWidget.dart';

import '../widgets/HomeAppBar.dart';
import 'home_screen.dart';

class PointsShopScreen extends StatefulWidget {
  const PointsShopScreen({super.key});

  @override
  State<PointsShopScreen> createState() => _PointsShopScreenState();
}

class PointShopData {
  int item_id;
  String item_name = "";
  int points;
  String item_code = "";
  int user_id;
  bool isSold = false;
  bool isClaimed = false;
  PointShopData(this.item_id, this.item_name, this.points, this.item_code,
      this.user_id, this.isSold, this.isClaimed);
}

class _PointsShopScreenState extends State<PointsShopScreen> {
  late SharedPreferences preferences;

  List<PointShopData> items = [];

  void initState() {
    super.initState;
    getUserData();
  }

  void getUserData() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> deductUserPoints(int pointsToDeduct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve current points value
    int currentPoints = prefs.getInt('user_points') ?? 0;

    // Deduct points
    int updatedPoints = currentPoints - pointsToDeduct;

    // Update points in SharedPreferences
    await prefs.setInt('user_points', updatedPoints);
  }

  Future<List<PointShopData>> _getRedeemShop() async {
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
    items = pointShops;
    return pointShops;
  }

  @override
  Widget build(BuildContext context) {
    print('henloo');
    final controller = Get.find<PointShopController>();
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 140, 52),
      appBar: AppBar(
        toolbarHeight: 120.10, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 255, 255, 255), // set your color
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Color.fromARGB(255, 255, 153, 0),
                          ),
                        ),
                        const Text(
                          "Point Shop",
                          style: TextStyle(
                            fontFamily: 'Inter-Black',
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.card_giftcard),
                      onPressed: () {},
                      iconSize: 23,
                    ),
                    // Text(
                    //   "420",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontFamily: 'Inter-bold',
                    //   ),
                    // ),
                    FutureBuilder(
                      builder: (BuildContext context, AsyncSnapshot snapshot4) {
                        if (preferences == null) {
                          return const Text(
                            "You currently don't have any points",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 115, 115, 115),
                            ),
                          );
                        } else {
                          return Text(
                            preferences.getInt('user_points').toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'Inter-',
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //     colors: [
          //       Color.fromARGB(255, 255, 203, 135),
          //       Color.fromARGB(255, 255, 156, 76),
          //     ],
          //     begin: const FractionalOffset(0.0, 0.0),
          //     end: const FractionalOffset(1.5, 0.0),
          //     stops: [0.0, 1.0],
          color: Color.fromARGB(255, 245, 245, 245),
          //     tileMode: TileMode.clamp),
        ),
        padding: const EdgeInsets.only(top: 15),
        child: Obx(() {
          return ListView.builder(
            itemCount: controller.pointshopdatas.length,
            itemBuilder: (BuildContext context, int index) {
              final data = controller.pointshopdatas[index];
              return Card(
                // color: (data.isSold) ? Colors.green : Colors.white,
                color: (data.isSold)
                    ? const Color.fromARGB(255, 0, 200, 40)
                    : const Color.fromARGB(255, 255, 255, 255),

                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                elevation: 5,
                child: ListTile(
                  title: Text(
                    data.item_name,
                    style: TextStyle(
                      fontFamily: 'Inter-black',
                      fontSize: 18,
                      color: (data.isSold)
                          ? const Color.fromARGB(255, 255, 255, 255)
                          : const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  subtitle: Text(
                    '${data.points.toString()} Points',
                    style: TextStyle(
                      fontFamily: 'Inter-semibold',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: (data.isSold)
                          ? Color.fromARGB(255, 255, 255, 255)
                          : Color.fromARGB(255, 104, 104, 104),
                    ),
                  ),
                  onTap: () {
                    if (preferences.getInt('user_points')! >= data.points &&
                        !data.isSold) {
                      // int? itemPoints = snapshot3.data[index].points;

                      // int userpoints =
                      //     preferences.getInt('user_points')! - itemPoints!;

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "You purchased ${data.item_name.toString()}.",
                            style: const TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          content: Text(
                            'You are about to purchase ${data.item_name.toString()}. This costs ${data.points.toString()} points. Are you sure you want to purchase this item?',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color.fromARGB(255, 106, 106, 106),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 185, 6),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () {
                                deductUserPoints(data.points);
                                controller.setItemAsSold(index);
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                "No",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else if (preferences.getInt('user_points')! <
                            data.points &&
                        !data.isSold) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Insufficient Points",
                            style: TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          content: Text(
                            'You do not have enough points to purchase ${data.item_name.toString()}. This costs ${data.points.toString()} points and you only have ${preferences.getInt('user_points').toString()} points.',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color.fromARGB(255, 106, 106, 106),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else if (data.isClaimed) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'You already claimed this item',
                            style: TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 128, 128, 128),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else if (!data.isClaimed) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'You already bought this item',
                            style: TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          content: Text(
                            'Item Name: ${data.item_name.toString()}\nItem Code:  ${data.item_code.toString()}\n\nYou have not claimed this item yet. Click Claimed once you have already received your item.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text(
                                  "Claimed",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 185, 6),
                                    fontFamily: 'Inter-bold',
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  controller.setItemAsClaimed(index);
                                  Navigator.pop(context);
                                }),
                            TextButton(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 128, 128, 128),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'You already bought this item',
                            style: TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          content: Text(
                            'Item Name: ${data.item_name.toString()}\nItem Code:  ${data.item_code.toString()}\n\nYou have not claimed this item yet. Click Claimed once you have already received your item.',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          actions: [
                            TextButton(
                                child: Text(
                                  "Claimed",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 185, 6),
                                    fontFamily: 'Inter-bold',
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  controller.setItemAsClaimed(index);
                                  Navigator.pop(context);
                                }),
                            TextButton(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

// onPressed: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => AlertDialog(
//                                     title: Text(
//                                       "Are you sure you want to purchase this item?",
//                                       style: TextStyle(
//                                         fontFamily: 'Inter-bold',
//                                         fontSize: 18,
//                                         color: Color.fromARGB(255, 0, 0, 0),
//                                       ),
//                                     ),
//                                     content: Text(
//                                       'You are about to purchase ${snapshot3.data[index].item_name.toString()}. Are you sure you want to purchase this item?',
//                                       style: TextStyle(
//                                         fontFamily: 'Inter-semibold',
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color:
//                                             Color.fromARGB(255, 106, 106, 106),
//                                       ),
//                                     ),
//                                     actions: [
//                                       ElevatedButton(
//                                         child: Text("Yes I'm sure!"),
//                                         onPressed: () => Navigator.pop(context),
//                                         style: ElevatedButton.styleFrom(
//                                           padding: EdgeInsets.all(10),
//                                           minimumSize: const Size(50, 40),
//                                           backgroundColor:
//                                               Color.fromARGB(255, 255, 153, 0),
//                                           elevation: 12.0,

//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
