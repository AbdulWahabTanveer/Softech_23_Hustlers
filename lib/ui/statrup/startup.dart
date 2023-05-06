import 'package:flutter/material.dart';
import 'package:softech_hustlers/ui/statrup/startup_controller.dart';

class StartUpScreen extends StatefulWidget {
  StartUpScreen({Key? key}) : super(key: key);

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
    return const Scaffold(
      body: Center(child: FlutterLogo(size: 200,)),
    );
  }
}
