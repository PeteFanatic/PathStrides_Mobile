// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pathstrides_mobile/Services/task_api.dart';

import '../Services/task_info.dart';
import '../text_widget.dart';
import '../Screens/home_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var tasks = <TaskInfo>[];
  @override
  void initState() {
    _getTask();
    super.initState();
  }

  Future _getTask() async {
    CallApi().getEmployeeTaskData('employeeTask').then((response) {
      Iterable list = json.decode(response.body);
      tasks = list.map((model) => TaskInfo.fromJson(model)).toList();
    });
  }
  // Future _getAnnouncement() async {
  //   CallApi().getAnnouncementData('employeeAnnounce').then((response) {
  //     Iterable list = json.decode(response.body);
  //     anns = list.map((model) => TaskInfo.fromJson(model)).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold();
  }
}
