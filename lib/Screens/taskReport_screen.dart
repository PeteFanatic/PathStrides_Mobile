import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Person All Data'),
      ),
      body: FutureBuilder(
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
                        title: Container(
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
                            child: Text(snapshot.data[index].report_text)),
                      ),
                    );
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
