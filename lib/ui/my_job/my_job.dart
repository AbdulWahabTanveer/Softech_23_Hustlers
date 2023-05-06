import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import '../../models/job_model.dart';
import '../add_new_Job/add_new_job.dart';
import 'my_job_controller.dart';

class MyJob extends StatelessWidget {
  MyJob({Key? key}) : super(key: key);
  final controller = Get.put(MyJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(
            left: kpHorizontalPadding.w,
            right: kpHorizontalPadding.w,
            bottom: 25.h,
          ),
          child: BusyButton(
              title: "Add New Job",
              isBusy: false,
              onPressed: () {
                Get.to(() => AddNewJob());
              })),
      extendBody: true,
      appBar: AppBar(
          title: Text(
        "My Post Job",
        style: appBarTextStyle,
      )),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
          stream: controller.getJobs(),
          builder: (_,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>?>> snapshot) {
            var items = snapshot.data?.docs ?? [];
            controller.myJobs.clear();
            items.forEach((element) {
              if (element.data()!.isNotEmpty) {
                controller.myJobs.add(JobModel.fromJson(element.data()!));
              }
            });
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding.w, vertical: 25.h),
                    child: controller.myJobs.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // Get.to(()=>JobDetails());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15.h),
                                  margin: EdgeInsets.only(top: 12.h),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CommonImageView(
                                          height: 60.h,
                                          width: 60.h,
                                          url: controller.myJobs[index].images[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.myJobs[index].title,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            5.verticalSpace,
                                            Text(
                                              "\$250",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            10.verticalSpace,
                                            Text(
                                              "13 may 2023",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 5.h),
                                            child: Text(
                                              "Status",
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: FaIcon(
                                                FontAwesomeIcons.trashCan,
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.myJobs.length,
                          )
                        : Container(child: const Text("No record found")),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
