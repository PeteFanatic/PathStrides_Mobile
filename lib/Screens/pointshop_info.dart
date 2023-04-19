import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PointShopInfo extends StatefulWidget {
  const PointShopInfo({super.key});

  @override
  State<PointShopInfo> createState() => _PointShopInfoState();
}

class _PointShopInfoState extends State<PointShopInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 220,
      child: PageView.builder(
        itemCount: 1,
        itemBuilder: (context, position) {
          return _buildPageItem(position);
        },
      ),
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          // height: 220,
          margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: index.isEven
                ? Color.fromARGB(221, 255, 214, 178)
                : Color.fromARGB(221, 217, 217, 217),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/bg6.jpg"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You currently have",
                    style: TextStyle(
                      fontFamily: 'Inter-semibold',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "420 Points",
                    style: TextStyle(
                      fontFamily: 'Inter-black',
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
