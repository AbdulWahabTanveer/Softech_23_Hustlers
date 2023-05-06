import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import '../add_new_Job/add_new_job.dart';

class MyPost extends StatelessWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "My Post Job",
        style: appBarTextStyle,
      )),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w,vertical: 25.h),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      // Get.to(()=>JobDetails());
                    },
                    child: Padding(
                      padding:  EdgeInsets.only(top: 12.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120.h,
                              child: UnconstrainedBox(
                                child: Padding(
                                  padding:  EdgeInsets.only(left: 15.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CommonImageView(
                                      height: 90.h,
                                      width: 90.w,
                                      url: "https://picsum.photos/200/300",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:12.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  30.verticalSpace,
                                  Text("Job Title",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                  5.verticalSpace,
                                  Text("\$250",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),),
                                  10.verticalSpace,
                                  Text("13 may 2023",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w700),),
                                  ],
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              height: 120.h,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 10.h),
                                child: Column(
                                  children: [
                                    10.verticalSpace,
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 5.h),
                                      child: Text("Status",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                    ),
                                    Spacer(),
                                    IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.trashCan))

                                  ],
                                ),
                              ),
                            ),
                            25.horizontalSpace,
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 20,
              ),
            ),
          ),
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  left: kpHorizontalPadding.w,
                right: kpHorizontalPadding.w,
                bottom: 25.h,
                  ),
              child: BusyButton(
                  title: "Request New Job", isBusy: false, onPressed: () {
                    Get.to(()=>AddNewJob());
              })),
        ],
      ),
    );
  }
}
