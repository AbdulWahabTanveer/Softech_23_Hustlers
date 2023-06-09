import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/models/user_model.dart';
import 'package:softech_hustlers/services/user_service.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/ui/authentication/login/login_screen.dart';
import 'package:softech_hustlers/ui/profile_edit/profile_edit.dart';

import '../../style/app_theme.dart';
import 'handyman_profile_controller.dart';

class HandyManProfile extends StatefulWidget {
  HandyManProfile({Key? key}) : super(key: key);

  @override
  State<HandyManProfile> createState() => _HandyManProfileState();
}

class _HandyManProfileState extends State<HandyManProfile> {
  final controller = Get.put(HandymanProfileController());

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = UserService.userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: appBarTextStyle,
        ),
        backgroundColor: Get.theme.primaryColor ==
            AppTheme.darkTheme.primaryColor
            ? appBackgroundColor
            : null,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async{
                            await Get.to(() => HandymanProfileEdit());
                            setState(() {});
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 62.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage: NetworkImage(
                                    UserService.userModel.profileImgUrl ??
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/925px-Unknown_person.jpg',
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 5.w,
                                  bottom: 5.h,
                                  child: const FaIcon(
                                    FontAwesomeIcons.penToSquare,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        Text(
                          userModel.userName,
                          style: white18w700,
                        ),
                        10.verticalSpace,
                        Text(
                          userModel.email,
                          style: white18w500,
                        ),
                        20.verticalSpace,
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: -60.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 120.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.sp)),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() {
                                    return Text(
                                      controller.noOfServices.value,
                                      style: theme16w700,
                                    );
                                  }),
                                  5.verticalSpace,
                                  Text(
                                    'Service\nDelivered',
                                    softWrap: true,
                                    style: grey14w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: 50.h,
                                  child: const VerticalDivider(
                                    color: Colors.black,
                                    width: 10,
                                  )),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '1',
                                    style: theme16w700,
                                  ),
                                  5.verticalSpace,
                                  Text(
                                    'Year(s) of\nExperience',
                                    softWrap: true,
                                    style: grey14w500,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              80.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Obx(() {
                  return Container(
                      height: 75.h,
                      decoration: BoxDecoration(
                        color: controller.availabitityColor.value,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Available Status",
                                    style: black16w700.copyWith(
                                        color: Get.theme.primaryColor ==
                                            AppTheme.darkTheme.primaryColor
                                            ? Colors.white
                                            : null),
                                  ),
                                  Obx(() {
                                    return Text(
                                      controller.availableStatus.value,
                                      style: black16w700.copyWith(
                                          color: controller
                                              .availabitityTextColor.value),
                                    );
                                  }),
                                ]),
                          ),
                          const Spacer(),
                          Obx(() {
                            return FlutterSwitch(
                              width: 60.w,
                              height: 30.h,
                              valueFontSize: 12.sp,
                              toggleSize: 12.sp,
                              value: controller.isOnline.value,
                              padding: 8.w,
                              showOnOff: true,
                              activeColor: Theme
                                  .of(context)
                                  .primaryColor,
                              onToggle: (bool value) {
                                controller.changeStatus();
                              },
                            );
                          }),
                          15.horizontalSpace,
                        ],
                      ));
                }),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.globe,
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor
                              ? Colors.white
                              : null),
                      title: Text(
                        'App Language',
                        style: black16w700.copyWith(color: Get.theme
                            .primaryColor ==
                            AppTheme.darkTheme.primaryColor
                            ? Colors.white
                            : Colors.black),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: FaIcon(
                          FontAwesomeIcons.sun, color: Get.theme.primaryColor ==
                          AppTheme.darkTheme.primaryColor
                          ? Colors.white
                          : null),
                      title: Text(
                        'App Theme',
                        style: black16w700.copyWith(color: Get.theme
                            .primaryColor ==
                            AppTheme.darkTheme.primaryColor
                            ? Colors.white
                            : Colors.black),
                      ),
                      trailing: SizedBox(
                        width: 60.w,
                        child: Obx(() {
                          return FlutterSwitch(
                            width: 60.w,
                            height: 30.h,
                            valueFontSize: 12.sp,
                            toggleSize: 12.sp,
                            value: controller.isNotification.value,
                            activeColor: Theme
                                .of(context)
                                .primaryColor,
                            padding: 8.w,
                            showOnOff: true,
                            onToggle: (bool value) {
                              controller.changeNotification();
                            },
                          );
                        }),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.lock,
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor
                              ? Colors.white
                              : null),
                      title: Text(
                        'Change password',
                        style: black16w700.copyWith(color: Get.theme
                            .primaryColor ==
                            AppTheme.darkTheme.primaryColor
                            ? Colors.white
                            : Colors.black),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.circleInfo,
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor
                              ? Colors.white
                              : null),
                      title: Text(
                        'About',
                        style: black16w700.copyWith(color: Get.theme
                            .primaryColor ==
                            AppTheme.darkTheme.primaryColor
                            ? Colors.white
                            : Colors.black),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Get.offAll(() => LoginScreen());
                      },
                      leading:
                      FaIcon(FontAwesomeIcons.arrowRightFromBracket,
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor
                              ? Colors.white
                              : null),
                      title: Text(
                        'Logout',
                        style: black16w700.copyWith(color: Get.theme
                            .primaryColor ==
                            AppTheme.darkTheme.primaryColor
                            ? Colors.white
                            : Colors.black),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
