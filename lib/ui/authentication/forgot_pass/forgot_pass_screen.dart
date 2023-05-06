import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_app_bar.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/ui/authentication/forgot_pass/forgot_pass_controller.dart';
import 'package:softech_hustlers/ui/authentication/login/login_controller.dart';

class ForgotPassScreen extends StatelessWidget {
  ForgotPassScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final ForgotPassController loginController = ForgotPassController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Obx(
                      () =>
                      loginController.sent.value ?
                      Center(
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomAppBar(),
                            30.verticalSpace,
                            _buildSuccessIcon(context),
                            20.verticalSpace,
                            Text('Success', style: ts20W800),
                            20.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 50.w),
                              child: Text(
                                'Password reset link sent on email.',
                                style: ts16W400,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            60.verticalSpace,
                            Obx(
                                  () => BusyButton(
                                title: "Go Back",
                                isBusy: loginController.loading.value,
                                onPressed: () async {
                                  Get.back();
                                },
                              ),
                            ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            //     Text("Don't have an account? ", style: grey12W400.copyWith(fontSize: 16.sp),),
                            //     Text('Sign Up', style: ts14w400.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800, fontSize: 16.sp),)
                            //   ],
                            // )
                          ],
                        ),
                      ):
                      Column(
                    children: [
                      50.verticalSpace,
                      _buildHelloUserIcon(context),
                      20.verticalSpace,
                      Text('Forgot Password?', style: ts20W800),
                      20.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        child: Text(
                          'Enter your email to proceed with password reset',
                          style: ts16W400,
                          textAlign: TextAlign.center,
                        ),
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
                      70.verticalSpace,
                      Obx(
                        () => BusyButton(
                          title: "Send Email",
                          isBusy: loginController.loading.value,
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              await loginController.sendLink(
                                  loginController.loginEmailCont.text);
                            }
                          },
                        ),
                      ),
                      60.verticalSpace,
                      // Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //     Text("Don't have an account? ", style: grey12W400.copyWith(fontSize: 16.sp),),
                      //     Text('Sign Up', style: ts14w400.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w800, fontSize: 16.sp),)
                      //   ],
                      // )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  _buildHelloUserIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: const Icon(
        Fontisto.locked,
        size: 45,
        color: Colors.white,
      ),
    );
  }

  _buildSuccessIcon(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: const Icon(
        Icons.verified,
        size: 60,
        color: Colors.white,
      ),
    );
  }

}
