import 'package:get/get.dart';
import 'package:softech_hustlers/enum/app_mode.dart';
import 'package:softech_hustlers/style/app_theme.dart';

class AppConfig{

 void changeToLightMode( ){
   Get.changeTheme(AppTheme.lightTheme);
 }

 void changeToDarkMode( ){
   Get.changeTheme(AppTheme.darkTheme);
 }

}