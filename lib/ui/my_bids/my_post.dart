import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/style/colors.dart';
import 'package:softech_hustlers/style/textstyles.dart';
import 'package:softech_hustlers/ui/detail/detailscreen.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import '../../models/bid_model.dart';
import '../../style/app_theme.dart';

class MyPost extends StatelessWidget {
  const MyPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor ==
      AppTheme.darkTheme.primaryColor
        ? appBackgroundColor
        : null,
          title: Text(
        "My Bids",
        style: appBarTextStyle,
      ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('bids')
              .where("handymanId",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots()
              .asyncMap((event) async {
            List<Map> result = [];
            for (var element in event.docs) {
              Bid bid = Bid.fromMap(element.data());
              var data = await FirebaseFirestore.instance
                  .collection('jobs')
                  .doc(bid.jobId)
                  .get();
              JobModel job = JobModel.fromJson(data.data()!);

              result.add({"job": job, "bid": bid});
            }

            return result;
          }),
          builder: (context, snapshot) {
            print(snapshot.data == null ? "ddddD" : snapshot.data!.length);
            if (snapshot.hasData) {
              print("dddddddd");
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: kpHorizontalPadding.w),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          JobModel job = snapshot.data![index]['job'];
                          Bid bid = snapshot.data![index]['bid'];
                          return InkWell(
                            onTap: () {
                              Get.to(() => DetailScreen(job));
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
                                      url: job.images[0],
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
                                          job.title,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        5.verticalSpace,
                                        Text(
                                          "\$${bid.amount}",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        10.verticalSpace,
                                        Text(
                                          "${DateFormat.yMMMd().format(job.date)}",
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
                                          color: Colors.green.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 5.h),
                                        child: Text(
                                          bid.accepted
                                              ? "Accepted"
                                              : bid.rejected
                                                  ? "Rejeccted"
                                                  : "Pending",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }),
    );
  }
}
