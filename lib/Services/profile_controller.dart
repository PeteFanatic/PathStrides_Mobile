import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? userName;
  String? email;
  String? department;
  String? status;
  String? contactNumber;
  String? token;
}

class ProfileController extends GetxController {
  late SharedPreferences preferences;
  final userProfile = UserProfileModel().obs;

  @override
  void onInit() async {
    setUserProfile();
    super.onInit();
  }

  void setUserProfile() async {
    preferences = await SharedPreferences.getInstance();
    print("User: ${preferences.getString('user_fname').toString()}");
    userProfile.value.firstName =
        preferences.getString('user_fname').toString();
    userProfile.value.middleName =
        preferences.getString('user_mname').toString();
    userProfile.value.lastName = preferences.getString('user_lname').toString();
    userProfile.value.userName =
        preferences.getString('user_username').toString();
    userProfile.value.email = preferences.getString('user_email').toString();
    userProfile.value.department =
        preferences.getString('user_department').toString();
    userProfile.value.status = preferences.getString('status').toString();
    userProfile.value.contactNumber =
        preferences.getString('contactnumber').toString();
    userProfile.value.token = preferences.getString('token').toString();
  }
}

    // String? f_name = preferences.getString('user_fname').toString();
    // String? m_name = preferences.getString('user_mname').toString();
    // if (m_name == null) {
    //   m_name = "";
    // }
    // String? l_name = preferences.getString('user_lname').toString();
    // String? username = preferences.getString('user_username').toString();
    // String? email = preferences.getString('user_email').toString();
    // String? department = preferences.getString('user_department').toString();
    // String? status = preferences.getString('status').toString();
    // String? contactnumber = preferences.getString('contactnumber').toString();
