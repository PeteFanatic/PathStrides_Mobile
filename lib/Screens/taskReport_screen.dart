import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pathstrides_mobile/Screens/task_report.dart';
import 'package:pathstrides_mobile/Screens/task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskReportData extends StatefulWidget {
  const TaskReportData({super.key});
  @override
  _TaskReportDataState createState() => _TaskReportDataState();
}

class TaskReportObject {
  int task_report_id;
  String report_text;

  TaskReportObject(this.task_report_id, this.report_text);
}

class _TaskReportDataState extends State<TaskReportData> {
  ///late TaskData taskview;
  late SharedPreferences preferences;
  void initState() {
    super.initState;
  }

  Future<List<TaskReportObject>> _getTaskReport() async {
    var response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/taskReport'));
    var jsonData = json.decode(response.body);
    late SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    int? user_id = preferences.getInt('user_id');
    List<TaskReportObject> taskReports = [];
    for (var p in jsonData) {
      TaskReportObject taskReport =
          TaskReportObject(p["task_report_id"], p["report_text"]);
      //int temp = p["user_id"];
      //if (temp == user_id || temp == null) {
      taskReports.add(taskReport);
      //}
    }
    print(taskReports.length);
    return taskReports;
  }

  @override
  Widget build(BuildContext context) {
    //int taskId = taskview.task_id;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
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
            Container(
              padding: const EdgeInsets.only(
                  top: 0.0, left: 10.0, bottom: 0.0, right: 0.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => TaskReport()));
                },

                // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    minimumSize: const Size(40, 40),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 255, 156, 76),
                    elevation: 12.0,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Inter-Bold',
                        fontSize: 24)),
                child: const Text('+'),
              ),
            ),
            SizedBox(
              width: 500,
              height: 500,
              child: FutureBuilder(
                future: _getTaskReport(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            TaskReportObject data = snapshot.data[index];
                            //TaskReportObject taskReportView;
                            List list = snapshot.data;
                            return Card(
                              child: ListTile(
                                title: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child:
                                        //Text(snapshot.data[index].task_report_id)),
                                        Image.network(
                                      "http://10.0.2.2:8000/api/show/${snapshot.data[index].task_report_id}",
                                      width: 300,
                                      height: 300,
                                    )),
                                subtitle: Center(
                                    child:
                                        Text(snapshot.data[index].report_text)),
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
