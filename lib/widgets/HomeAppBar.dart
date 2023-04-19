import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../Screens/home_screen.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
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
                        fontFamily: 'Inter-Bold',
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 45,
                  height: 45,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 255, 126, 45),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
