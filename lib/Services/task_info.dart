// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals

// import 'dart:convert';

class TaskInfo {
  int task_id = 0;
  String task_title = "";
  String task_desc = "";
  String points = "";
  String address = "";
  // int status = 0;
  int user_id = 0;

  TaskInfo(int task_id, String task_title, String task_desc, String points,
      String location, int emp_id, int man_id) {
    this.task_id = task_id;
    this.task_title = task_title;
    this.task_desc = task_desc;
    this.points = points;
    this.address = address;
    // this.status = status;
    this.user_id = user_id;
  }

  TaskInfo.fromJson(Map json)
      : task_id = json['task_id'],
        task_title = json['task_title'],
        task_desc = json['task_desc'],
        points = json['points'],
        address = json['address'],
        // status = json['status'],
        user_id = json['user_id'];
}
