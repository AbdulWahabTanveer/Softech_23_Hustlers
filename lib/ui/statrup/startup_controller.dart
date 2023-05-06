import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/services/user_service.dart';
import 'package:softech_hustlers/ui/authentication/login/login_screen.dart';
import 'package:softech_hustlers/ui/profile/handyman_profile.dart';
import 'package:softech_hustlers/ui/profile_edit/profile_edit.dart';

class StartUpController extends GetxController{

  @override
  void onInit() {
    print('on init called');
    initialize();
    super.onInit();
  }

  Future initialize() async{
    if(FirebaseAuth.instance.currentUser==null){
      await Future.delayed(const Duration(seconds: 2));
      Get.off(()=>LoginScreen());
    }
    else{
      await UserService.initialize();
      Get.off(()=>HandyManProfile());
    }
  }
}