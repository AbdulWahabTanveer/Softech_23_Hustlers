import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:softech_hustlers/style/app_theme.dart';
import 'package:softech_hustlers/style/textstyles.dart';

class HandyManProfile extends StatelessWidget {
  const HandyManProfile({Key? key}) : super(key: key);

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
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 62.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundImage:
                                const AssetImage('assets/images/softech.png'),
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
              Container(
                  child: Column(children:  [
                    const Text("Available Status"),
                    const Text("You are online"),
                    FlutterSwitch(
                      width: 125.0,
                      height: 55.0,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: true,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true, onToggle: (bool value) {  },

                    ),
              ])),
            ],
          ),
        ),
      ),
    );
  }
}
