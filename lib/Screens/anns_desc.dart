import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/announcement_screen.dart';

class AnnounceDescription extends StatelessWidget {
  final AnnouncementData announceview;
  AnnounceDescription(this.announceview);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        toolbarHeight: 70.10, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
            ),
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
                                builder: (context) =>
                                    const AnnouncementScreen(),
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
                          "Announcement",
                          style: TextStyle(
                            fontFamily: 'Inter-Black',
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(top: 20, left: 10.0, right: 0.0),
                child: Text(
                  announceview.anns_title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30.0, fontFamily: 'Inter-black'),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    top: 30, left: 20.0, right: 0.0, bottom: 0),
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontFamily: 'Inter-bold'),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: 0.0, left: 10.0, bottom: 0.0, right: 10.0),
                  height: 500,
                  width: 380,
                  child: Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 5,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 10.0, bottom: 0.0, right: 0.0),
                        child: Text(
                          announceview.anns_desc,
                          style: TextStyle(
                              fontFamily: 'Inter-regular', fontSize: 14),
                        ),
                      ))),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   child: BottomNav(),
      // ),
    );
  }
}
