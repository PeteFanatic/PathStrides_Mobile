// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class PointsShopScreen extends StatefulWidget {
  const PointsShopScreen({super.key});

  @override
  State<PointsShopScreen> createState() => _PointsShopScreenState();
}

class PointShopData {
  int item_id;
  String item_name = "";
  int points;
  int user_id;
  PointShopData(this.item_id, this.item_name, this.points, this.user_id);
}

class _PointsShopScreenState extends State<PointsShopScreen> {
  Future<List<PointShopData>> _getRedeemShop() async {
    var data3 =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/employeePointShop'));
    var jsonData = json.decode(data3.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? user_id = preferences.getInt('user_id');
    List<PointShopData> pointShops = [];
    for (var p in jsonData) {
      PointShopData pointShop = PointShopData(
          p["item_id"], p["item_name"], p["points"], p["user_id"]);
      int temp = p["user_id"];
      if (temp == user_id && user_id != null) {
        pointShops.add(pointShop);
      }
    }
    print(pointShops.length);
    return pointShops;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 140, 52),
      appBar: AppBar(
        toolbarHeight: 100.10, //set your height
        flexibleSpace: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(10),
          color: Color.fromARGB(255, 255, 255, 255),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
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
                        left: 10,
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
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot4) {
                          snapshot4.connectionState == ConnectionState.done &&
                                  snapshot4.hasData
                              ? const Text("You currently don't have points",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    color: Color.fromARGB(255, 115, 115, 115),
                                  ))
                              : Text(
                                  snapshot4.data
                                      .getInt('user_points')
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    color: Color.fromARGB(255, 115, 115, 115),
                                  ),
                                );

                          return const Placeholder();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ) // set your color
            ),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 203, 135),
                Color.fromARGB(255, 255, 156, 76),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        padding: const EdgeInsets.only(top: 15),
        child: FutureBuilder(
          future: _getRedeemShop(),
          builder: (BuildContext context, AsyncSnapshot snapshot3) {
            if (snapshot3.data == null) {
              return const Center(
                child: Text(
                  'No items to show.',
                ),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot3.data.length,
                itemBuilder: (BuildContext context, int index) {
                  PointShopData data = snapshot3.data[index];
                  // PointShopData pointShopview;
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Text(
                        snapshot3.data[index].item_name,
                        style: const TextStyle(
                            fontFamily: 'Inter-black', fontSize: 18),
                      ),
                      subtitle: Text(
                        '${snapshot3.data[index].points.toString()} Points',
                        style: const TextStyle(
                          fontFamily: 'Inter-semibold',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 106, 106, 106),
                        ),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                            "Are you sure you want to purchase this item?",
                            style: TextStyle(
                              fontFamily: 'Inter-bold',
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          content: Text(
                            'You are about to purchase ${snapshot3.data[index].item_name.toString()}. This costs ${snapshot3.data[index].points.toString()} points. Are you sure you want to purchase this item?',
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
                                  color: Color.fromARGB(255, 3, 192, 31),
                                  fontFamily: 'Inter-bold',
                                  fontSize: 16,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
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
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      // bottomNavigationBar: Container(
      //   child: BottomNav(),
      // ),
    );
  }
}
