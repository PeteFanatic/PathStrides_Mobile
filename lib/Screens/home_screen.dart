import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Screens/login_screen.dart';
import 'package:pathstrides_mobile/Services/getX.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'announcement_screen.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void getUser() async {
  //   var data =
  //       await http.get(Uri.parse('http://10.0.2.2:8000/api/employeeUser'));
  //   var jsonData = json.decode(data.body);
  //   late SharedPreferences preferences;
  //   preferences = await SharedPreferences.getInstance();
  // }

  Future<List<TaskData>> _getTask() async {
    var data =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/employeeTask'));
    var jsonData = json.decode(data.body);
    // late SharedPreferences preferences;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    //int? user_id = preferences.getInt('user_id');
    List<TaskData> tasks = [];
    for (var u in jsonData) {
      TaskData task = TaskData(
          u["task_id"],
          u["user_id"],
          u["task_title"],
          u["task_desc"],
          u["points"],
          u["address"],
          u["lat"],
          u["lng"],
          u["status"],
          u["deadline"]);
      //int temp = u["user_id"];
      //if (temp == user_id) {
      tasks.add(task);
      //}
    }
    print(tasks.length);

    return tasks;
  }

  Future<List<AnnouncementData>> _getAnnouncement() async {
    var data2 =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/employeeAnnounce'));
    var jsonData = json.decode(data2.body);

    List<AnnouncementData> announcements = [];
    for (var a in jsonData) {
      AnnouncementData announcement =
          AnnouncementData(a["anns_id"], a["anns_title"], a["anns_desc"]

              //a["status"],
              //a["user_id"],
              );
      announcements.add(announcement);
    }
    print(announcements.length);
    return announcements;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Color.fromARGB(255, 240, 240, 240),
              ),
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                      builder: (context) => const LoginScreen())),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 0.0, bottom: 0.0, right: 260.0),
              child: const Text(
                "Welcome ",
                style: TextStyle(
                  fontFamily: 'Inter-medium',
                  fontSize: 16,
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
              ),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 255, 126, 45),
          elevation: 5,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.only(
                    top: 20.0, left: 20.0, bottom: 0.0, right: 310.0),
                child: const Text('Tasks',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.only(
                    top: 24.0, left: 334.0, bottom: 0.0, right: 0.0),
                child: const Text('See All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 60.0, left: 20.0, bottom: 0.0, right: 0.0),
                  height: 500,
                  width: 353,
                  child: FutureBuilder(
                    future: _getTask(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null || snapshot.data.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  final controller =
                                      Get.find<NavBarController>();
                                  controller.tabIndex(2);
                                },
                                // ignore: unnecessary_new
                                child: new Container(
                                  height: 200,
                                  width: 900,
                                  margin: const EdgeInsets.only(
                                      top: 0.0,
                                      left: 0.0,
                                      bottom: 0.0,
                                      right: 0.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: snapshot.data[index].status !=
                                              "Finished"
                                          ? const [
                                              Color.fromARGB(255, 255, 163, 87),
                                              Color.fromARGB(255, 207, 102, 37),
                                            ]
                                          : const [
                                              Color.fromARGB(255, 26, 156, 76),
                                              Color.fromARGB(255, 8, 105, 16),
                                            ],
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 20.0,
                                          left: 10.0,
                                          bottom: 0.0,
                                          right: 0.0),
                                      // child: Text(
                                      //   snapshot.data[index].task_title,
                                      //   style: TextStyle(
                                      //     fontFamily: 'Inter-black',
                                      //     fontSize: 24,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              //textAlign: TextAlign.left,
                                              snapshot.data[index].task_title,
                                              style: const TextStyle(
                                                fontFamily: 'Inter-black',
                                                fontSize: 24,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index].address,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter-regular',
                                                  fontSize: 14,
                                                  color: Colors.white),
                                            ),
                                            // Text(
                                            //   "",
                                            //   style: TextStyle(
                                            //       fontFamily: 'Inter-regular',
                                            //       fontSize: 14,
                                            //       color: Colors.white),
                                            // ),
                                            const Divider(
                                              color: Colors.white,
                                              thickness: 2,
                                            ),
                                            Text(
                                              snapshot.data[index].task_desc,
                                              style: const TextStyle(
                                                fontFamily: 'Inter-regular',
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ])),
                                ));
                          },
                        );
                      }
                    },
                  )),
              Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.only(
                    top: 300.0, left: 20.0, bottom: 0.0, right: 210.0),
                child: const Text('Announcements',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.only(
                    top: 305.0, left: 334.0, bottom: 0.0, right: 0.0),
                child: const Text('See All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  padding: const EdgeInsets.only(
                      top: 350.0, left: 20.0, bottom: 0.0, right: 0.0),
                  height: 800,
                  width: 373,
                  child: FutureBuilder(
                    future: _getAnnouncement(),
                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                      if (snapshot2.data == null || snapshot2.data.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            // AnnouncementData data = snapshot2.data[index];
                            return GestureDetector(
                                onTap: () {
                                  final controller =
                                      Get.find<NavBarController>();
                                  controller.tabIndex(1);
                                },
                                child: Container(
                                  height: 200,
                                  width: 900,
                                  margin: const EdgeInsets.only(
                                      top: 0.0,
                                      left: 0.0,
                                      bottom: 0.0,
                                      right: 0.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: const [
                                          Color.fromARGB(255, 255, 87, 87),
                                          Color.fromARGB(255, 207, 37, 37),
                                        ]),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 20.0,
                                          left: 10.0,
                                          bottom: 0.0,
                                          right: 0.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              //textAlign: TextAlign.left,
                                              snapshot2.data[index].anns_title,
                                              style: const TextStyle(
                                                fontFamily: 'Inter-black',
                                                fontSize: 24,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.white,
                                              thickness: 2,
                                            ),
                                            Text(
                                              snapshot2.data[index].anns_desc,
                                              style: const TextStyle(
                                                fontFamily: 'Inter-regular',
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ])),
                                ));
                          },
                        );
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
