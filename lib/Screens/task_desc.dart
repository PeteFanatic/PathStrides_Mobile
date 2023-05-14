// ignore_for_file: must_be_immutable

import 'package:pathstrides_mobile/Screens/geolocation_screen.dart';
import 'package:pathstrides_mobile/Screens/taskReport_screen.dart';
import 'package:pathstrides_mobile/Screens/task_report.dart';

import 'package:flutter/material.dart';
import 'package:pathstrides_mobile/Services/navigation_screen.dart';
import '../Screens/task_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class TaskDescription extends StatefulWidget {
  TaskData taskview;
  TaskDescription(this.taskview, {super.key});

  @override
  State<TaskDescription> createState() => _TaskDescriptionState();
}

class _TaskDescriptionState extends State<TaskDescription> {
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
                                builder: (context) => const TaskScreen(),
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
                          "Tasks",
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
                  widget.taskview.task_title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30.0, fontFamily: 'Inter-black'),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(left: 10.0, right: 0.0),
                child: Text(
                  widget.taskview.address,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 83, 83, 83),
                      fontFamily: 'Inter-bold'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 10.0, left: 0.0, bottom: 5.0, right: 200.0),
                child: Text(
                  "Earning points: ${widget.taskview.points} points",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: 'Inter-semibold'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 0.0, left: 0.0, bottom: 0.0, right: 224.0),
                child: Text(
                  "Deadline: ${widget.taskview.deadline}",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontFamily: 'Inter-semibold'),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    top: 20, left: 20.0, right: 0.0, bottom: 0),
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
                height: 250,
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
                      widget.taskview.task_desc,
                      style:
                          TextStyle(fontFamily: 'Inter-regular', fontSize: 14),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: 30.0, left: 0.0, bottom: 0.0, right: 0.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NavigationScreen(
                                  double.parse(widget.taskview.lat),
                                  double.parse(widget.taskview.lng),
                                  taskview: widget.taskview,
                                )));
                      },

                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
                          minimumSize: const Size(150, 40),
                          backgroundColor: Color.fromARGB(255, 255, 153, 0),
                          elevation: 12.0,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter-Bold',
                              fontSize: 18)),
                      child: const Text('Start Task'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 30.0, left: 0.0, bottom: 0.0, right: 0.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => TaskReport(
                                  taskview: widget.taskview,
                                )));
                      },

                      // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
                          minimumSize: const Size(150, 40),
                          backgroundColor: Color.fromARGB(255, 71, 71, 71),
                          elevation: 12.0,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter-Bold',
                              fontSize: 18)),
                      child: const Text('Task Report'),
                    ),
                  )
                ],
              ),
              // Container(
              //   alignment: Alignment.topLeft,
              //   margin: const EdgeInsets.only(
              //       top: 20, left: 20.0, right: 0.0, bottom: 0),
              //   child: Text(
              //     "Comments",
              //     textAlign: TextAlign.left,
              //     style: TextStyle(
              //         fontSize: 16.0,
              //         color: Colors.black,
              //         fontFamily: 'Inter-bold'),
              //   ),
              // ),
              // Container(
              //   padding: EdgeInsets.only(
              //     top: 10.0,
              //     left: 10.0,
              //     bottom: 0.0,
              //     right: 10.0,
              //   ),
              //   height: 100,
              //   width: 380,
              //   child: const Card(
              //     color: Colors.white,
              //     margin: EdgeInsets.symmetric(
              //       horizontal: 0,
              //       vertical: 5,
              //     ),
              //     child: Padding(
              //       padding: EdgeInsets.only(
              //         top: 10.0,
              //         left: 10.0,
              //         bottom: 0.0,
              //         right: 0.0,
              //       ),
              //       child: Text(
              //         '',
              //         style: TextStyle(
              //           fontFamily: 'Inter-regular',
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => NavigationScreen(
              //             double.parse(widget.taskview.lat),
              //             double.parse(widget.taskview.lng))));
              //   },

              //   // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
              //   style: ElevatedButton.styleFrom(
              //       padding: EdgeInsets.only(
              //           top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
              //       minimumSize: const Size(80, 40),
              //       backgroundColor: Color.fromARGB(255, 255, 153, 0),
              //       elevation: 12.0,
              //       textStyle: const TextStyle(
              //           color: Colors.white,
              //           fontFamily: 'Inter-Bold',
              //           fontSize: 18)),
              //   child: const Text('Send'),
              // ),
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
