import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData {
  int? task_id;
  int? user_id = 0;
  String? task_title = "";
  String? task_desc = "";
  int? points;
  String? address = "";
  String? lat = "";
  String? lng = "";
  String? status = "";
  String? deadline = "";
}

class TaskController extends GetxController {
  late SharedPreferences preferences;
  final taskController = TaskData().obs;

  @override
  void onInit() async {
    preferences = await SharedPreferences.getInstance();
    setTaskData();
    super.onInit();
  }

  void setTaskData() {}
}
