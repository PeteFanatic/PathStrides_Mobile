//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'home_screen.dart';
// ignore_for_file: unused_field, non_constant_identifier_names
import 'dart:convert';
import 'package:path/path.dart' as path;
// import 'package:http/http.dart' show MediaType;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'dart:async';
//import 'dart:convert';
import 'dart:io';
//import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pathstrides_mobile/Screens/taskReport_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:pathstrides_mobile/Screens/task_desc.dart';
import '../Screens/task_screen.dart';
import '../image_Controller.dart';
import '../rounded_button.dart';

class TaskReport extends StatefulWidget {
  // late TaskData taskview;
  // ignore: avoid_types_as_parameter_names
  const TaskReport({super.key, required this.taskview});
  final TaskData taskview;

  @override
  _TaskReportState createState() => _TaskReportState();
}

class _TaskReportState extends State<TaskReport> {
  // late TaskData taskview;
  late SharedPreferences preferences;

  TextEditingController nameController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  PickedFile? pickedFile;
  final picker = ImagePicker();
  File? _image;
  Future choiceImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
    //FilePickerResult? result = await FilePicker.platform.pickFiles();
// if (result != null) {
//   String path = result.files.single.path!;
//   // upload the file to Laravel
// }
  }

  void loadImage() {
    _image = File('path/to/image.jpg');
  }

  Future uploadImage(File imageFile) async {
    final uri = Uri.parse("http://10.0.2.2:8000/api/upload-image");
    // Assuming you have an image file called "image.png" in your project directory
    //File imageFile = File('image.png');
    //late SharedPreferences preferences;
    late TaskData taskview;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //preferences = await SharedPreferences.getInstance();
    int? user_id = preferences.getInt('user_id');
    int taskIdInt = widget.taskview.task_id;
    String userId = user_id.toString();
    String taskId = taskIdInt.toString();
// Send a POST request with the image data to your Laravel API endpoint
    var request = http.MultipartRequest('POST', uri);
    request.fields['report_text'] = nameController.text;
    request.fields['user_id'] = userId;
    request.fields['task_id'] = taskId;
    request.headers['Content-Type'] = 'multipart/form-data';
    // var pic =
    //     await http.MultipartFile.fromPath("report_image_url", imageFile.path);
    var pic = await http.MultipartFile.fromPath('image', imageFile.path,
        filename: path.basename(imageFile.path));
    print(imageFile.path);
    request.files.add(pic);
    var response = await request.send();
    http.Response responseJson = await http.Response.fromStream(response);
    print(responseJson.body);
    //  print(jsonMap);
    if (response.statusCode == 200) {
      print('Image Uploaded');
    } else {
      print('Image not uploaded');
    }
    nameController.text = "";
// Handle the server response here
    // print(await response.stream.bytesToString());
  }

  @override
  Widget build(BuildContext context) {
    ImageController imageController = Get.put(ImageController());
    Get.lazyPut(() => ImageController());
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: const Color.fromARGB(255, 255, 126, 45),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TaskScreen()));
            },
          ),
          title: Text(
            "Task Report",
            style: TextStyle(
              fontFamily: 'Inter-bold',
              color: Colors.black,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 240, 240, 240),
          elevation: 0,
        ),
        body: SafeArea(
          //padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //GetBuilder<ImageController>(builder: (imageController) {
                //return
                Container(
                    padding: EdgeInsets.only(
                        top: 20, left: 0.0, right: 0.0, bottom: 10),
                    child: Container(
                      width: 350,
                      height: 300,
                      padding: EdgeInsets.only(
                          top: 20, left: 100.0, right: 100.0, bottom: 0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 126, 45)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(height: 35),
                          Container(
                            // ignore: unnecessary_null_comparison
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 200,
                            // child: imageController.pickedFile != null
                            //     ? Image.file(
                            //         File(imageController.pickedFile!.path),
                            //         width: 300,
                            //         height: 300,
                            //         fit: BoxFit.cover)
                            //     : const Text('No Image Selected'),
                            child: _image == null
                                ? Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 100.0,
                                  )
                                : Image.file(_image!,
                                    width: 300, height: 300, fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    )),
                ElevatedButton(
                  child: const Text('Select Image'),
                  onPressed: () => choiceImage(),
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(
                          top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
                      minimumSize: const Size(150, 40),
                      backgroundColor: Color.fromARGB(255, 255, 153, 0),
                      foregroundColor: Colors.white,
                      elevation: 12.0,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter-Bold',
                          fontSize: 18)),
                ),
                //}),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(
                      top: 20, left: 23.0, right: 0.0, bottom: 10),
                  child: Text(
                    "Caption:",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontFamily: 'Inter-bold'),
                  ),
                ),
                Container(
                  width: 350,
                  height: 150,
                  margin: const EdgeInsets.only(
                      top: 0, left: 0.0, right: 0.0, bottom: 0),
                  child: TextFormField(
                    controller: nameController,
                    minLines: 4,
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Enter your report...',
                      hintStyle: TextStyle(fontFamily: 'Inter-regular'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                ),

                Container(
                    padding: const EdgeInsets.only(
                        top: 0, left: 0.0, right: 0.0, bottom: 0),
                    child: RoundedButton(
                        btnText: 'Submit',
                        onBtnPressed: () {
                          uploadImage(_image!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskReportData()));
                        }))
              ],
            ),
          ),
        ));
  }
}
