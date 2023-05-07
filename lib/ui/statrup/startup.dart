import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softech_hustlers/ui/statrup/startup_controller.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

class StartUpScreen extends StatefulWidget {
  const StartUpScreen({Key? key}) : super(key: key);

  @override
  State<StartUpScreen> createState() => _StartUpScreenState();
}

class _StartUpScreenState extends State<StartUpScreen> {
  final StartUpController startUpController = StartUpController();

  @override
  void initState() {
    startUpController.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/logo.jpg',height: 500.h,width: 500.w,)),
    );
  }
}
