import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/style/app_theme.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import 'handyman_profile_controller.dart';

class HandyManProfile extends StatelessWidget {
  HandyManProfile({Key? key}) : super(key: key);
  final controller = Get.put(HandymanProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Profile',
            style: appBarTextStyle,
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ]),
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
                        CircleAvatar(
                          radius: 62.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundImage: const NetworkImage(
                              'https://picsum.photos/200/300',
                            ),
                          ),
                        ),
                        20.verticalSpace,
                        Text(
                          'Softech Hustlers',
                          style: white18w700,
                        ),
                        10.verticalSpace,
                        Text(
                          'Handyman@pornhub.com',
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
                                  Text(
                                    '93',
                                    style: theme16w700,
                                  ),
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
                                    style: black16w700,
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
                      leading: FaIcon(FontAwesomeIcons.globe),
                      title: Text(
                        'App Language',
                        style: black16w700,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.sun),
                      title: Text(
                        'App Theme',
                        style: black16w700,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.lock),
                      title: Text(
                        'Change password',
                        style: black16w700,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.circleInfo),
                      title: Text(
                        'About',
                        style: black16w700,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.cloudArrowDown),
                      title: Text(
                        'Optional Notification',
                        style: black16w700,
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
