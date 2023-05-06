import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/ui/authentication/login_controller.dart';

import '../../style/common.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final SignInController loginController = SignInController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
          child: Column(
            children: [
              60.verticalSpace,
              Text('Hello Again!', style: ts20W800),
              20.verticalSpace,
              Text('Welcome Back, You Have Been\n Missed For A Long Time', style: ts16W400,textAlign: TextAlign.center,),
              CustomTextField(controller: loginController.loginEmailCont, validator: loginController.emailValidation, label: "Email", suffix: Icon(Fontisto.email, size: 25.h,), hint: "Enter Email",),
              20.verticalSpace,
              CustomTextField(controller: loginController.loginPassCont, validator: loginController.emailValidation, label: "Password", suffix: Icon(Fontisto.locked, size: 25.h,),hint: "Enter Password"),
              40.verticalSpace,
              BusyButton(title: "Sign In", isBusy: loginController.)
              


            ],
          ),
        ),
      ),
    );
  }
}
