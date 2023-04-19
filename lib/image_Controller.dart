import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  PickedFile? _pickedFile;
  Uint8List? _bytesImage;
  String? base64Image;
  File? _image;
  PickedFile? get pickedFile => _pickedFile;
  final _picker = ImagePicker();
  Future<void> pickImage() async {
    // ignore: deprecated_member_use
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);

    update();
  }

  void loadImage() {
    _image = File('path/to/image.jpg');
  }

//updateimage= update profile
  Future<bool> upload() async {
    Uint8List _bytesImage;
    update();
    bool success = false;
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    http.StreamedResponse response = await updateImage(_pickedFile);
    String base64Image;
    http.StreamedResponse imageBytes = response;
    base64Image = base64Encode(response as List<int>);
    _bytesImage = Base64Decoder().convert(base64Image);
    //_isLoading = false;
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());

      _image = File(pickedFile!.path);
      print('No image selected.');
      String message = map["message"];
      success = true;
      print(message);
    } else {
      print("error posting the image");
    }
    update();
    return success;
  }

//updateprofile = updateImage
  Future<http.StreamedResponse> updateImage(PickedFile? data) async {
    http.MultipartRequest request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8000/api/upload-image'));
    // request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    if (GetPlatform.isMobile && data != null) {
      File _file = File(data.path);
      request.files.add(http.MultipartFile(
          'image', _file.readAsBytes().asStream(), _file.lengthSync(),
          filename: _file.path.split('/').last));
    }
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<void> choiceImage() async {
    // ignore: deprecated_member_use
    // final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    // if (!mounted) {
    //   return;
    // }
    // if (pickedFile != null) {
    //   setState(() {
    //     _image = File(pickedFile.path);
    //   });
    // }
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future submit() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/upload-image'),
    );

    // Add the file to the request
    if (_image != null) {
      var image = await http.MultipartFile.fromPath('image', _image!.path);
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _image!.path,
      ));
    }
    // Send the request
    var response = await request.send();
    http.Response responseJson = await http.Response.fromStream(response);
    Map<String, dynamic> jsonMap = jsonDecode(responseJson.body);
    // Check if the request was successful
    if (response.statusCode == 200) {
      // Read the response from the server
      // var responseJson = await response.stream.bytesToString();

      return jsonMap;
    } else {
      // The request failed
      print("Image Fail");
    }
  }

//   Future<http.StreamedResponse> uploadImage(PickedFile? data) async {
//     // Assuming you have an image file called "image.png" in your project directory
//     File imageFile = File('image.png');

// // Send a POST request with the image data to your Laravel API endpoint
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('http://yourlaravelapp.com/api/upload-image'));
//     request.files
//         .add(await http.MultipartFile.fromPath('image', imageFile.path));
//     http.StreamedResponse response = await request.send();

// // Handle the server response here
//     print(await response.stream.bytesToString());
//   }
}
