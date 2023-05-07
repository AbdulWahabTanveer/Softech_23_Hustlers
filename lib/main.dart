import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:softech_hustlers/style/app_theme.dart';
import 'package:softech_hustlers/ui/add_new_Job/add_new_job.dart';
import 'package:softech_hustlers/ui/dahsboard/userDashBoard.dart';
import 'package:softech_hustlers/ui/my_job/my_job.dart';
import 'package:softech_hustlers/ui/statrup/startup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(392.727272, 825.4545),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          darkTheme: AppTheme.darkTheme,
          themeMode: GetStorage().read('theme') ?? false
              ? ThemeMode.dark
              : ThemeMode.light,
          // You can use the library anywhere in the app even in theme
          theme: AppTheme.lightTheme,
          home: child,
        );
      },
      child: StartUpScreen(),
    );
  }
}
