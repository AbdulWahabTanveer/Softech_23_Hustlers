import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/ui/authentication/forgot_pass/forgot_pass_screen.dart';
import 'package:softech_hustlers/ui/authentication/login/login_controller.dart';
import 'package:softech_hustlers/ui/authentication/sign_up/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final SignInController loginController = SignInController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  100.verticalSpace,
                  Text('Hello Again!', style: ts20W800),
                  20.verticalSpace,
                  Text(
                    'Welcome Back, You Have Been\n Missed For A Long Time',
                    style: ts16W400,
                    textAlign: TextAlign.center,
                  ),
                  60.verticalSpace,
                  CustomTextField(
                    controller: loginController.loginEmailCont,
                    validator: loginController.emailValidation,
                    label: "Email",
                    suffix: Icon(
                      Icons.email,
                      size: 25.h,
                    ),
                    hint: "Enter email here",
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: loginController.loginPassCont,
                    validator: loginController.passValidation,
                    label: "Password",
                    suffix: Icon(
                      Icons.lock,
                      size: 25.h,
                    ),
                    hint: "Enter password here",
                    hideText: true,
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.to(() => ForgotPassScreen());
                          },
                          child: Text(
                            'Forgot password?',
                            style: ts16W400.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic),
                          )),
                    ],
                  ),
                  30.verticalSpace,
                  Obx(
                    () => BusyButton(
                      title: "Sign In",
                      isBusy: loginController.loading.value,
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await loginController.signIn(
                              loginController.loginEmailCont.text,
                              loginController.loginPassCont.text);
                        }
                      },
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: grey12W400.copyWith(fontSize: 16.sp),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Text(
                            'Sign Up',
                            style: ts14w400.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
