import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HandymanProfileController extends GetxController {
  Rx<String> availableStatus= 'You are Online'.obs;
  Rx<bool> isOnline = true.obs;
  Rx<Color> availabitityColor = Colors.green.withOpacity(0.5).obs;
  Rx<Color> availabitityTextColor = Colors.green.obs;


  void changeStatus() {
    if (availableStatus.value == 'You are Online') {
      availableStatus.value = 'You are Offline';
      isOnline.value = false;
      availabitityColor.value = Colors.red.withOpacity(0.5);
      availabitityTextColor.value = Colors.red;
    } else {
      availableStatus.value = 'You are Online';
      isOnline.value = true;
      availabitityColor.value = Colors.green.withOpacity(0.5);
      availabitityTextColor.value = Colors.green;
    }
  }
}