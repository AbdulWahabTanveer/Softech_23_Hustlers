import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditController extends GetxController{
  TextEditingController fname=TextEditingController();
  TextEditingController lname=TextEditingController();
  TextEditingController uname=TextEditingController();
  TextEditingController cnic=TextEditingController();
  TextEditingController contactNumber=TextEditingController();
  TextEditingController location=TextEditingController();
  Rx<bool> isUploading = false.obs;
  Rx<XFile?> profilePic=Rx<XFile?>(null);

  Future<void> pickImage() async {
    profilePic.value=await ImagePicker.platform.getImage(source: ImageSource.gallery);
  }
}