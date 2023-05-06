import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HandymanProfileController extends GetxController {
  Rx<String> availableStatus = 'You are Online'.obs;
  Rx<bool> isOnline = true.obs;
  Rx<Color> availabitityColor = Colors.green.withOpacity(0.2).obs;
  Rx<Color> availabitityTextColor = Colors.green.obs;

  Rx<bool> isNotification = Rx<bool>(GetStorage().read('theme') ?? false);

  void changeStatus() {
    if (availableStatus.value == 'You are Online') {
      availableStatus.value = 'You are Offline';
      isOnline.value = false;
      availabitityColor.value = Colors.red.withOpacity(0.3);
      availabitityTextColor.value = Colors.red;
    } else {
      availableStatus.value = 'You are Online';
      isOnline.value = true;
      availabitityColor.value = Colors.green.withOpacity(0.5);
      availabitityTextColor.value = Colors.green;
    }
  }

  void changeNotification() {
    if (isNotification.value) {
      isNotification.value = false;
      GetStorage().write('theme', false);
      Get.changeThemeMode(ThemeMode.light);
    } else {
      isNotification.value = true;
      Get.changeThemeMode(ThemeMode.dark);
      GetStorage().write('theme', true);
    }
  }
}
