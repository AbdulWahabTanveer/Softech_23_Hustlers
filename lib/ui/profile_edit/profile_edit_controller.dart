import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softech_hustlers/models/user_model.dart';

import '../../services/user_service.dart';

class ProfileEditController extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController location = TextEditingController();
  LatLng? position;
  Rx<bool> isUploading = false.obs;
  Rx<XFile?> profilePic = Rx<XFile?>(null);
  RxList<dynamic>? selectedCategory = <dynamic>[].obs;

  @override
  void onInit() {
    userNameController.text = UserService.userModel.userName;
    if (UserService.userModel.cnic != null && UserService.userModel.cnic != 0) {
      cnicController.text = (UserService.userModel.cnic!.toString());
    }
    contactNumber.text = UserService.userModel.phoneNo?.toString() ?? '';
    location.text = UserService.userModel.location ?? '';
    selectedCategory!.value = UserService.userModel.serviceCategory ?? [];

    super.onInit();
  }

  Future<void> pickImage() async {
    ImagePicker imagePicker = ImagePicker();
    profilePic.value =
        (await imagePicker.pickImage(source: ImageSource.gallery));
  }

  String? generalValidation(String? v) {
    if (v == null || v.isEmpty) {
      return "Field is required";
    }
    return null;
  }

  Future<void> updateProfile() async {
    try {
      isUploading.value = true;
      String? downloadUrl;

      if (profilePic.value != null) {
        downloadUrl = await uploadImageAndGetUrl();
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'userName': userNameController.text,
        'cnic': cnicController.text,
        'phoneNo': contactNumber.text,
        'location': location.text,
        'lat': position?.latitude,
        'lng': position?.longitude,
        'profileImgUrl': downloadUrl,
        ' servicesCategory': selectedCategory!.value
      });

      UserService.userModel = UserModel(
          serviceCategory: selectedCategory!.value,
          userName: userNameController.text,
          accountType: UserService.userModel.accountType,
          email: UserService.userModel.email,
          emailVerified: UserService.userModel.emailVerified,
          cnic: int.tryParse(cnicController.text),
          lat: position?.latitude,
          lng: position?.longitude,
          profileImgUrl: downloadUrl);
    } catch (e) {
      Get.snackbar("Request Failed", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      // print(e);
    }

    isUploading.value = false;
  }

  Future<String> uploadImageAndGetUrl() async {
    String downloadUrl = '';
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("file ${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(File(profilePic.value!.path));
    await uploadTask.then((res) async {
      downloadUrl = await res.ref.getDownloadURL();
    });
    return downloadUrl;
  }
}
