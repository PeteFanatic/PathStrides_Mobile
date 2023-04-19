import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathstrides_mobile/Screens/login_screen.dart';
import 'package:pathstrides_mobile/Screens/profile_screen.dart';
import 'package:pathstrides_mobile/Screens/task_desc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'announcement_screen.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'anns_desc.dart';
import 'dashboard_screen.dart';
import 'task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
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
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    int? user_id = preferences.getInt('user_id');
    List<TaskData> tasks = [];
    for (var u in jsonData) {
      TaskData task = TaskData(
          u["task_id"],
          u["task_title"],
          u["task_desc"],
          u["points"],
          u["address"],
          u["lat"],
          u["lng"],
          // u["status"],
          u["user_id"],
          u["deadline"]);
      int temp = u["user_id"];
      if (temp == user_id) {
        tasks.add(task);
      }
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
      AnnouncementData announcement = AnnouncementData(
        a["anns_id"],
        a["anns_title"],
        a["anns_desc"],
        a["location"],
        a["anns_lat"],
        a["anns_long"],

        //a["status"],
        //a["user_id"],
      );
      announcements.add(announcement);
    }
    print(announcements.length);
    return announcements;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 240, 240, 240),
              ),
              onPressed: () => Navigator.of(context, rootNavigator: true)
                  .pushReplacement(MaterialPageRoute(
                      builder: (context) => new LoginScreen())),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 20.0, left: 0.0, bottom: 0.0, right: 260.0),
              child: new Text(
                "Welcome, ",
                style: TextStyle(
                  fontFamily: 'Inter-medium',
                  fontSize: 16,
                  color: Color.fromARGB(255, 240, 240, 240),
                ),
              ),
            ),
          ],
          backgroundColor: Color.fromARGB(255, 255, 126, 45),
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
                child: Text('See All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: 60.0, left: 20.0, bottom: 0.0, right: 0.0),
                  height: 500,
                  width: 353,
                  child: FutureBuilder(
                    future: _getTask(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null || snapshot.data.isEmpty) {
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            TaskData data = snapshot.data[index];
                            TaskData taskview;

                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TaskScreen()));
                                },
                                // ignore: unnecessary_new
                                child: new Container(
                                  height: 200,
                                  margin: const EdgeInsets.only(
                                      top: 0.0,
                                      left: 0.0,
                                      bottom: 0.0,
                                      right: 0.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: snapshot.data[index].task_id != 1
                                          ? [
                                              Color.fromARGB(255, 196, 35, 35),
                                              Color.fromARGB(255, 255, 45, 45),
                                            ]
                                          : [
                                              Color.fromARGB(255, 44, 0, 0),
                                              Color.fromARGB(255, 170, 0, 0),
                                            ],
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: ListTile(
                                    title: Container(
                                      margin: const EdgeInsets.only(
                                          top: 20.0,
                                          left: 0.0,
                                          bottom: 0.0,
                                          right: 0.0),
                                      child: Text(
                                        snapshot.data[index].task_title,
                                        style: TextStyle(
                                          fontFamily: 'Inter-black',
                                          fontSize: 24,
                                          color:
                                              snapshot.data[index].task_id == 1
                                                  ? Color.fromARGB(
                                                      255, 240, 240, 240)
                                                  : Color.fromARGB(
                                                      255, 255, 126, 45),
                                        ),
                                      ),
                                    ),
                                    subtitle: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10.0,
                                            left: 0.0,
                                            bottom: 0.0,
                                            right: 240.0),
                                        child: Column(children: [
                                          Text(
                                            snapshot.data[index].address,
                                            style: TextStyle(
                                              fontFamily: 'Inter-regular',
                                              fontSize: 18,
                                              color: snapshot.data[index]
                                                          .task_id ==
                                                      1
                                                  ? Color.fromARGB(
                                                      255, 240, 240, 240)
                                                  : Color.fromARGB(
                                                      255, 255, 126, 45),
                                            ),
                                          ),
                                          Text(
                                            snapshot.data[index].task_desc,
                                            style: TextStyle(
                                              fontFamily: 'Inter-regular',
                                              fontSize: 18,
                                              color: snapshot.data[index]
                                                          .task_id ==
                                                      1
                                                  ? Color.fromARGB(
                                                      255, 240, 240, 240)
                                                  : Color.fromARGB(
                                                      255, 255, 126, 45),
                                            ),
                                          ),
                                        ])),
                                    isThreeLine: true,
                                  ),
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
                child: Text('See All',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Inter-Regular',
                        fontSize: 12.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: 350.0, left: 20.0, bottom: 0.0, right: 0.0),
                  height: 800,
                  width: 373,
                  child: FutureBuilder(
                    future: _getAnnouncement(),
                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                      if (snapshot2.data == null || snapshot2.data.isEmpty) {
                        return Container(
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            AnnouncementData data = snapshot2.data[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AnnouncementScreen()));
                              },
                              child: new Container(
                                height: 200,
                                margin: const EdgeInsets.only(
                                    top: 0.0,
                                    left: 0.0,
                                    bottom: 0.0,
                                    right: 0.0),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: snapshot2.data[index].anns_id == 1
                                          ? [
                                              Color.fromARGB(255, 196, 35, 35),
                                              Color.fromARGB(255, 255, 126, 45),
                                            ]
                                          : [
                                              Color.fromARGB(255, 0, 88, 29),
                                              Color.fromARGB(255, 0, 151, 50),
                                            ],
                                    ),
                                    color: snapshot2.data[index].anns_id == 1
                                        ? Colors.red
                                        : Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: ListTile(
                                  leading: Text(
                                    snapshot2.data[index].anns_title,
                                    style: TextStyle(
                                      fontFamily: 'Inter-black',
                                      fontSize: 24,
                                      color: snapshot2.data[index].anns_id == 1
                                          ? Color.fromARGB(255, 240, 240, 240)
                                          : Color.fromARGB(255, 255, 126, 45),
                                    ),
                                  ),
                                  title: Container(
                                    margin: const EdgeInsets.only(
                                        top: 0.0,
                                        left: 0.0,
                                        bottom: 0.0,
                                        right: 0.0),
                                    child: Text(
                                      snapshot2.data[index].location,
                                      style: TextStyle(
                                        fontFamily: 'Inter-semibold',
                                        fontSize: 12,
                                        color: snapshot2.data[index].anns_id ==
                                                1
                                            ? Color.fromARGB(255, 240, 240, 240)
                                            : Color.fromARGB(255, 255, 126, 45),
                                      ),
                                    ),
                                  ),
                                  trailing: Text(
                                    snapshot2.data[index].anns_desc,
                                    style: TextStyle(
                                      fontFamily: 'Inter-semibold',
                                      fontSize: 12,
                                      color: snapshot2.data[index].anns_id == 1
                                          ? Color.fromARGB(255, 240, 240, 240)
                                          : Color.fromARGB(255, 255, 126, 45),
                                    ),
                                  ),
                                ),
                              ),
                            );
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
