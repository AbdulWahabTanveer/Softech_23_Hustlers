import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HandymanProfileController extends GetxController {
  Rx<String> availableStatus= 'You are Online'.obs;
  get isOnline=> availableStatus.value == 'You are Online';

  void changeStatus() {
    if (availableStatus.value == 'You are Online') {
      availableStatus.value = 'You are Offline';
    } else {
      availableStatus.value = 'You are Online';
    }
  }
}