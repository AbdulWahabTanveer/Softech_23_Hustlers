import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:uuid/uuid.dart';

import '../map/map.dart';

class AddNewJobController extends GetxController{
  var jobTitle=TextEditingController();
  var jobDescription=TextEditingController();
  var price=TextEditingController();
  var date=TextEditingController();
  var time=TextEditingController();
  var picture=TextEditingController();
  var location=TextEditingController();
  double latitude=0.0;
  double longitude=0.0;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  RxList<XFile> jobImages=RxList<XFile>([]);

  final formKey = GlobalKey<FormState>();

  Rx<bool> isBusy =false.obs;

  Rx<String?> selectedCategory = Rx<String?>(null);

  String address="";

  Future<void> pickImage() async {
    var image=await ImagePicker.platform.getImage(source: ImageSource.gallery);
    if(image!=null){
      jobImages.add(image);
    }
  }

  Future<void> pickDate(BuildContext context) async {
    var pickedDate=await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if(pickedDate!=null){
      selectedDate=pickedDate;
      date.text=pickedDate.toString().split(" ")[0];
    }
  }

  void pickTime(BuildContext context) async {
    var picked =await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if(picked!=null){
      time.text=picked.format(context);
      selectedTime=picked;
    }
  }

  Future<void> addJob() async {
    isBusy.value=true;
    List<String> images=[];
    if(formKey.currentState!.validate()&&selectedCategory.value!=null){
      for(int i=0;i<jobImages.length;i++){
        var image=jobImages[i];
        var imageName=Uuid().v1();
        var storageRef=FirebaseStorage.instance.ref().child("jobs/$imageName");
         await storageRef.putFile(File(image.path));
          var url=await storageRef.getDownloadURL();
          images.add(url);
      }
      selectedDate=selectedDate.copyWith(hour: selectedTime.hour,minute: selectedTime.minute);
      var job=JobModel(
        date: selectedDate,
        description: jobDescription.text,
        images: images,
        price: double.parse(price.text),
        title: jobTitle.text, lat: '0', long: '0', uid: FirebaseAuth.instance.currentUser!.uid,
        status: "pending",
        category: "pending", id: Uuid().v1(),
      );
      await FirebaseFirestore.instance.collection("jobs").doc(job.id).set(job.toJson());
      isBusy.value=false;
      Get.back();
      Get.snackbar("Success", "Job added successfully",backgroundColor: Colors.white);
    }else if(selectedCategory.value==null){
      Get.snackbar("Unable to continue", "Please select category",backgroundColor: Colors.white);
      isBusy.value=false;
    }else{
      Get.snackbar("Error", "Please fill all fields",backgroundColor: Colors.white);
      isBusy.value=false;
    }
  }

  Future<void> ontapLocation() async {
    var result = await Get.to(() => GoogleMapScreen());
    if(result!=null) {
      LatLng latlng = result["location"];
      latitude = latlng.latitude;
      longitude =
          latlng.longitude;
      Placemark? placeMark = result["address"];
      String? name = placeMark!.name;
      String? subLocality = placeMark.subLocality;
      String? locality = placeMark.locality;
      String? administrativeArea = placeMark.administrativeArea;
      String? postalCode = placeMark.postalCode;
      String? country = placeMark.country;
       address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
      location.text = address;
    }
  }


}