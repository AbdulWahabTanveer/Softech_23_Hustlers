import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/ui/detail_customer/detail_customer_controller.dart';

import '../../global_widgets/busy_button.dart';
import '../../style/app_theme.dart';
import '../../style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';

class DetailCustomerScreen extends StatefulWidget {
  const DetailCustomerScreen(this.job, {Key? key}) : super(key: key);
  final JobModel job;

  @override
  State<DetailCustomerScreen> createState() => _DetailCustomerScreenState();
}

class _DetailCustomerScreenState extends State<DetailCustomerScreen> {
  int currentSlider = 0;
  final controller = Get.put(DetailCustomerController());

  Future<UserModel> getUser() async {
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.job.uid)
        .get();
    return UserModel.fromMap(doc.data()!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: widget.job.status == "InProgress"
              ? Padding(
                  padding: EdgeInsets.all(10.h),
                  child: BusyButton(
                    title: 'Mark as Complete',
                    isBusy: false,
                    onPressed: () async {
                      bool isConfirmed = false;
                      // await FirebaseFirestore.instance.collection("jobs").doc(widget.job.id).update({"status":"completed"});
                      await Get.defaultDialog(
                          title: "",
                          content: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              children: [
                                Text(
                                  "Are you sure you want to mark this job as complete?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppTheme.darkTheme.primaryColor==Get.theme.primaryColor ? Colors.white:Colors.black),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          // await FirebaseFirestore.instance.collection("jobs").doc(widget.job.id).update({"status":"completed"});
                                          isConfirmed = true;
                                          Get.back();
                                        },
                                        child: Text("Yes")),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("No")),
                                  ],
                                )
                              ],
                            ),
                          ));
                      if (isConfirmed) {
                        await Get.defaultDialog(
                            title: "Rate Your Handyman",
                            titlePadding: EdgeInsets.all(18.w),
                            content: Column(
                              children: [
                                RatingBarWidget(
                                  onRatingChanged: (val) {
                                    controller.ratingBar = val;
                                  },
                                  itemCount: 5,
                                  size: 30.w,
                                ),
                                15.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: CustomTextField(
                                      controller: controller.review,
                                      validator: (val) {},
                                      label: "Review",
                                      hint: "Review"),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.w),
                                  child: BusyButton(
                                      title: "Add Review",
                                      isBusy: false,
                                      onPressed: () async {
                                        await controller.uploadReview(widget.job.handymanId!);
                                        Get.back();
                                        Get.back();
                                      }),
                                )
                              ],
                            ));
                      }
                    },
                  ),
                )
              : null,
          body: Container(
            height: 1.sh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            height: 370.h,
                            viewportFraction: 1,
                            onPageChanged: (index, _) {
                              setState(() {
                                currentSlider = index;
                              });
                            }),
                        items: widget.job.images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(i))));
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                          bottom: 110.h,
                          left: 20.w,
                          child: SizedBox(
                            height: 50.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: widget.job.images.length,
                                itemBuilder: (context, index) {
                                  return UnconstrainedBox(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5.h),
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              width: index == currentSlider
                                                  ? 2
                                                  : 0),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.network(
                                                      widget.job.images[index])
                                                  .image),
                                          borderRadius:
                                              BorderRadius.circular(10.w)),
                                    ),
                                  );
                                }),
                          )),
                      Positioned(
                        bottom: -80.h,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10.w),
                          child: Container(
                            height: 140.h,
                            width: 0.8.sw,
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.category,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Get.theme.primaryColor ==
                                              AppTheme.darkTheme.primaryColor
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                10.verticalSpace,
                                Text(
                                  widget.job.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                10.verticalSpace,
                                Text(
                                  "\$ ${widget.job.price}",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                10.verticalSpace,
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 30.h,
                        left: 30.w,
                        child: Container(
                          height: 34.h,
                          width: 34.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon:  Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.black,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  120.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'Description',
                      style: TextStyle(
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor ? Colors.white:Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      widget.job.description,
                      style: TextStyle(color:  Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'Timing',
                      style: TextStyle(
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor ? Colors.white:Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      "${widget.job.date.hour.toString().padLeft(2, '0')}:${widget.job.date.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'Status',
                      style: TextStyle(
                          color: Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor ? Colors.white:Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      widget.job.status,
                      style: TextStyle(
                        color: Get.theme.primaryColor ==
                            AppTheme.darkTheme.primaryColor ? Colors.grey:Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          )),
    );
  }
}
