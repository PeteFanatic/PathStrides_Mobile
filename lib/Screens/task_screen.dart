// ignore_for_file: unused_local_variable, prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pathstrides_mobile/Screens/task_desc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'home_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class TaskData {
  int task_id;
  int user_id = 0;
  String task_title = "";
  String task_desc = "";
  int points;
  String address = "";
  String lat = "";
  String lng = "";
  String status = "";
  String deadline = "";

  TaskData(
      {required this.task_id,
      required this.user_id,
      required this.task_title,
      required this.task_desc,
      required this.points,
      required this.address,
      required this.lat,
      required this.lng,
      required this.status,
      required this.deadline});
}

class _TaskScreenState extends State<TaskScreen> {
  Future<List<TaskData>> _getTask() async {
    var data =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/employeeTask'));
    var jsonData = json.decode(data.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? user_id = preferences.getInt('user_id');
    List<TaskData> tasks = [];
    for (var u in jsonData) {
      TaskData task = TaskData(
          task_id: u["task_id"],
          user_id: u["user_id"],
          task_title: u["task_title"],
          task_desc: u["task_desc"],
          points: u["points"],
          address: u["address"],
          lat: u["lat"],
          lng: u["lng"],
          status: u["status"],
          deadline: u["deadline"]);

      if (task.user_id == user_id && task.status != "Completed") {
        tasks.add(task);
      }
    }
    print(tasks.length);

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        Text(
                          " Tasks",
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
        child: FutureBuilder(
          future: _getTask(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  TaskData data = snapshot.data[index];
                  return Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].task_title,
                        style:
                            TextStyle(fontFamily: 'Inter-black', fontSize: 18),
                      ),
                      subtitle: Text(
                        snapshot.data[index].address,
                        style: TextStyle(
                            fontFamily: 'Inter-semibold', fontSize: 12),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color.fromARGB(255, 255, 126, 45),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TaskDescription(data)));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
