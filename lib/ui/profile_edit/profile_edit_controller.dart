import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileEditController extends GetxController{
  TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController uname=TextEditingController();
  TextEditingController cnic=TextEditingController();
  TextEditingController contactNumber=TextEditingController();
  Rx<bool> isUploading = false.obs;
}