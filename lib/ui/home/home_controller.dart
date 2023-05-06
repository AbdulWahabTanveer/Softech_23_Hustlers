import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/job_model.dart';
import '../../services/user_service.dart';

class HomeController extends GetxController {
  String? currentLocation;
  RxBool enableLocation = false.obs;
  RxBool locationLoading = false.obs;
  LatLng? userCurrentPos;
  Rx<int> currentSlider = 0.obs;
  List<JobModel> featureJobs = [];
  RxList<JobModel> currentJobs = <JobModel>[].obs;
  List<JobModel> removeJobs = [];

  onIndexChange(index, _) {
    currentSlider.value = index;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.back();
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.back();
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> setAddress() async {
    print(enableLocation.value);
    if (enableLocation.value) {
      enableLocation.value = false;
      currentJobs.addAll(removeJobs);
      removeJobs = [];
    } else {
      locationLoading.value = true;
      Position position = await _determinePosition();
      userCurrentPos = LatLng(position.latitude, position.longitude);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark placeMark = placemarks[0];
      String? name = placeMark.name;
      String? subLocality = placeMark.subLocality;
      String? locality = placeMark.locality;
      String? administrativeArea = placeMark.administrativeArea;
      String? postalCode = placeMark.postalCode;
      String? country = placeMark.country;
      String? address =
          "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";
      currentLocation = address;
      locationLoading.value = false;

      enableLocation.value = true;
      var tempList = List.from(currentJobs);
      for (int i = 0; i < tempList.length; i++) {
        print("index $i");
        double dis = Geolocator.distanceBetween(
            tempList[i].lat,
            tempList[i].lng,
            userCurrentPos!.latitude,
            userCurrentPos!.longitude);
        print(dis / 1000);
        if ((dis / 1000) > 10) {
          removeJobs.add(tempList[i]);
          currentJobs.remove(tempList[i]);
        }
        print("index $i completed");
      }
    }
  }

  Future<List<JobModel>> futureFunction() async {
    print(UserService.userModel.serviceCategory);

    featureJobs = [];
    List<JobModel> jobs = [];
    QuerySnapshot<Map<String, dynamic>> tempFeature = await FirebaseFirestore
        .instance
        .collection("jobs")
        .where("feature", isEqualTo: true)
        .get();
    tempFeature.docs.forEach((element) {
      JobModel tempJob = JobModel.fromJson(element.data());
      featureJobs.add(tempJob);
    });

    return jobs;
  }
}
