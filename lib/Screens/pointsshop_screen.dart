import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pathstrides_mobile/Screens/pointshop_info.dart';
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
  int points_id;
  String points_name = "";
  int points;
  int user_id;
  PointShopData(this.points_id, this.points_name, this.points, this.user_id);
}

class _PointsShopScreenState extends State<PointsShopScreen> {
  late SharedPreferences preferences;
  void initState() {
    super.initState;
    getUserData();
  }

  void getUserData() async {
    preferences = await SharedPreferences.getInstance();
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
      PointShopData pointShop = PointShopData(
          p["points_id"], p["points_name"], p["points"], p["user_id"]);
      int temp = p["user_id"];
      if (temp == user_id || temp == null) {
        pointShops.add(pointShop);
      }
    }
    print(pointShops.length);
    return pointShops;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 140, 52),
      appBar: AppBar(
        toolbarHeight: 120.10, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Color.fromARGB(255, 255, 255, 255), // set your color
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
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Color.fromARGB(255, 255, 153, 0),
                          ),
                        ),
                        Text(
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
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.card_giftcard),
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
                          return Text(
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
                            style: TextStyle(
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
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 203, 135),
                Color.fromARGB(255, 255, 156, 76),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        padding: EdgeInsets.only(top: 15),
        child: FutureBuilder(
          future: _getRedeemShop(),
          builder: (BuildContext context, AsyncSnapshot snapshot3) {
            if (snapshot3.data == null) {
              return Container(
                child: Center(
                  child: Text(
                    'No items to show.',
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot3.data.length,
                itemBuilder: (BuildContext context, int index) {
                  PointShopData data = snapshot3.data[index];
                  PointShopData pointShopview;
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Text(
                        snapshot3.data[index].points_name,
                        style:
                            TextStyle(fontFamily: 'Inter-black', fontSize: 18),
                      ),
                      subtitle: Text(
                        '${snapshot3.data[index].points.toString()} Points',
                        style: TextStyle(
                          fontFamily: 'Inter-semibold',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 106, 106, 106),
                        ),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            "Are you sure you want to purchase this item?",
                            style: TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          content: Text(
                            'You are about to purchase ${snapshot3.data[index].points_name.toString()}. This costs ${snapshot3.data[index].points.toString()} points. Are you sure you want to purchase this item?',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color.fromARGB(255, 106, 106, 106),
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 3, 192, 31),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text(
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
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        child: BottomNav(),
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
//                                       'You are about to purchase ${snapshot3.data[index].points_name.toString()}. Are you sure you want to purchase this item?',
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