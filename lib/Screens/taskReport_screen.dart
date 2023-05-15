// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pathstrides_mobile/Screens/task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskReportData extends StatefulWidget {
  final TaskData taskview;
  const TaskReportData({super.key, required this.taskview});
  @override
  _TaskReportDataState createState() => _TaskReportDataState();
}

class TaskReportObject {
  int task_report_id;
  int user_id;
  int task_id;
  String? report_text;

  TaskReportObject(
      {required this.task_report_id,
      required this.user_id,
      required this.task_id,
      required this.report_text});
}

class _TaskReportDataState extends State<TaskReportData> {
  Future<List<TaskReportObject>> _getTaskReport() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/taskReport'));

    final jsonData = json.decode(response.body);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('user_id');
    List<TaskReportObject> taskReports = [];

    for (var task in jsonData) {
      final report = TaskReportObject(
          task_id: task['task_id'],
          task_report_id: task['task_report_id'],
          user_id: task['user_id'],
          report_text: task['report_text']);

      if (userId == report.user_id) {
        taskReports.add(report);
      }
    }

    return taskReports;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70.10, //set your height
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
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
                                builder: (context) => const TaskScreen(),
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
                          "Task Report",
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
        child: Column(
          children: [
            SizedBox(
              width: 500,
              height: 500,
              child: FutureBuilder(
                future: _getTaskReport(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TaskReportObject>> snapshot) {
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            TaskReportObject data =
                                snapshot.data!.elementAt(index);
                            return SizedBox(
                              width: 100,
                              child: Card(
                                child: ListTile(
                                  title: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child:
                                          //Text(snapshot.data[index].task_report_id)),
                                          Image.network(
                                        "http://10.0.2.2:8000/api/show/${data.task_report_id}",
                                        width: 300,
                                        height: 300,
                                      )),
                                  subtitle: Center(
                                      child: Text(data.report_text ?? "")),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
