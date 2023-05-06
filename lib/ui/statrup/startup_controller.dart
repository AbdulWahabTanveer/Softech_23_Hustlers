import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/enum/account_type.dart';
import 'package:softech_hustlers/services/user_service.dart';
import 'package:softech_hustlers/ui/authentication/login/login_screen.dart';
import 'package:softech_hustlers/ui/dahsboard/handymandashboard.dart';
import 'package:softech_hustlers/ui/dahsboard/userDashBoard.dart';

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
      if(UserService.userModel.accountType==AccountType.customer){
        Get.off(()=>const UserDashBoard());
      }
      else{
        Get.off(()=>const HandyManDashBoard());
      }
    }
  }
}