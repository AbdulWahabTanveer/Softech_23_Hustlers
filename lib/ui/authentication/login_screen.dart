import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
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
          padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
          child: Column(
            children: [
              100.verticalSpace,
              Text('Hello Again!', style: ts20W800),
              20.verticalSpace,
              Text('Welcome Back, You Have Been\n Missed For A Long Time', style: ts16W400,textAlign: TextAlign.center,),
              60.verticalSpace,
              CustomTextField(controller: loginController.loginEmailCont, validator: loginController.emailValidation, label: "Email", suffix: Icon(Icons.email, size: 25.h,), hint: "Enter email here",),
              20.verticalSpace,
              CustomTextField(controller: loginController.loginPassCont, validator: loginController.emailValidation, label: "Password", suffix: Icon(Icons.lock, size: 25.h,),hint: "Enter password here"),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?', style: ts16W400.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),

                ],
              ),
              70.verticalSpace,
              Obx(() => BusyButton(title: "Sign In", isBusy: loginController.loading.value,onPressed: ()=> loginController.signIn(loginController.loginEmailCont.text, loginController.loginPassCont.text),),),
              60.verticalSpace,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Don't have an account? ", style: grey12W400.copyWith(fontSize: 16.sp),),
                  Text('Sign Up', style: ts14w400.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800, fontSize: 16.sp),)

                ],
              )





            ],
          ),
        ),
      ),
    );
  }
}

