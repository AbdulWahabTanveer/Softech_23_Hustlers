import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/enum/account_type.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_dropdown.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/global_widgets/services_category_dropdown.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/colors.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/ui/authentication/login/login_screen.dart';
import 'package:softech_hustlers/ui/authentication/sign_up/sign_up_controller.dart';

import '../../../style/app_theme.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignUpController signUpController = SignUpController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

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
                  50.verticalSpace,
                  _buildHelloUserIcon(context),
                  20.verticalSpace,
                  Text('Hello User!', style: ts20W800),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Text(
                      'Create Your Account for Better Experience',
                      style: ts16W400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  40.verticalSpace,
                  CustomTextField(
                    controller: signUpController.nameCont,
                    validator: signUpController.nameValidation,
                    label: "Name",
                    suffix: Icon(
                      Icons.person,
                      size: 25.h,
                    ),
                    hint: "Enter Full name",
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: signUpController.loginEmailCont,
                    validator: signUpController.emailValidation,
                    label: "Email",
                    suffix: Icon(
                      Icons.email,
                      size: 25.h,
                    ),
                    hint: "Enter email here",
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: signUpController.loginPassCont,
                    validator: signUpController.passValidation,
                    label: "Password",
                    suffix: Icon(
                      Icons.lock,
                      size: 25.h,
                    ),
                    hint: "Enter password here",
                    hideText: true,
                  ),
                  20.verticalSpace,
                  Obx(() => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomDropdownSelect(
                            dropdownItems: const ['Handyman', 'Customer'],
                            onChange: (String v) {
                              signUpController.selectedRole.value = v;
                            },
                            value: signUpController.selectedRole.value.isEmpty
                                ? null
                                : signUpController.selectedRole.value,
                            label: "Account Type",
                            validator: signUpController.accountTypeValidation,
                          ),
                          signUpController.selectedRole.value.toLowerCase() ==
                                  AccountType.handyman.name
                              ? Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.h),
                                  child: ServiceCategoryDropdown(
                                    onChange: (String v) {
                                      signUpController.selectedCategory!.add(v);
                                    },
                                    value: null,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: 10.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              children: signUpController.selectedCategory!
                                  .map(
                                    (e) => PillItem(
                                        item: e,
                                        onCrossTap: () {
                                          signUpController.selectedCategory!
                                              .remove(e);
                                        }),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      )),
                  // Obx(() => ,),

                  40.verticalSpace,
                  Obx(
                    () => BusyButton(
                      title: "Sign Up",
                      isBusy: signUpController.loading.value,
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await signUpController.signUp(
                              signUpController.loginEmailCont.text,
                              signUpController.loginPassCont.text);
                        }
                      },
                    ),
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: grey12W400.copyWith(fontSize: 16.sp),
                      ),
                      InkWell(
                          onTap: () {
                            Get.to(() => LoginScreen());
                          },
                          child: Text(
                            'Sign In',
                            style: ts14w400.copyWith(
                                color: Get.theme.primaryColor ==
                                    AppTheme.darkTheme.primaryColor? Colors.white:Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: 16.sp),
                          ))
                    ],
                  ),
                  40.verticalSpace,
                ],
              ),
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
        Fontisto.person,
        size: 45,
        color: Colors.white,
      ),
    );
  }
}

class PillItem extends StatelessWidget {
  const PillItem({Key? key, required this.item, required this.onCrossTap})
      : super(key: key);
  final String item;
  final void Function() onCrossTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      margin: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 6.w,
          ),
          InkWell(
            onTap: onCrossTap,
            child: const Icon(
              Icons.close,
              size: 17,
              color: Colors.white54,
            ),
          )
        ],
      ),
    );
  }
}
