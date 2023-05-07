import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/models/user_model.dart';
import 'package:softech_hustlers/style/colors.dart';
import 'package:softech_hustlers/ui/detail/detailscreen.dart';
import 'package:softech_hustlers/ui/home/home_controller.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import '../../services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    print("Hhh");
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder(
              future: homeController.futureFunction(),
              builder: (context, AsyncSnapshot<List<JobModel>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 1.sh,
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.bottomCenter,
                            children: [
                              GetBuilder(
                                init: homeController,
                                builder: (con) => CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    height: 300.0,
                                    viewportFraction: 1,
                                    onPageChanged: homeController.onIndexChange,
                                  ),
                                  items: homeController.featureJobs.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: CommonImageView(
                                                fit: BoxFit.cover,
                                                url: i.images[0]));
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                              Positioned(
                                  bottom: 30.h,
                                  child: homeController.featureJobs.length == 1
                                      ? SizedBox()
                                      : SizedBox(
                                          height: 30.h,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: homeController
                                                  .featureJobs.length,
                                              itemBuilder: (context, index) {
                                                return UnconstrainedBox(
                                                  child: Obx(
                                                    () => Container(
                                                      margin: EdgeInsets.only(
                                                          right: 5.h),
                                                      height: 8.h,
                                                      width: index ==
                                                              homeController
                                                                  .currentSlider
                                                                  .value
                                                          ? 15.h
                                                          : 8.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.w)),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )),
                              Positioned(
                                  bottom: -25.h,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(
                                        () => InkWell(
                                          onTap: homeController.setAddress,
                                          child: Material(
                                            elevation: 5,
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                            color: homeController
                                                    .enableLocation.value
                                                ? primaryColor
                                                : Colors.white,
                                            child: Container(
                                              height: 50.h,
                                              width: 0.7.sw,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: homeController
                                                            .enableLocation
                                                            .value
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  10.horizontalSpace,
                                                  SizedBox(
                                                    width: 0.49.sw,
                                                    child: Text(
                                                      homeController
                                                              .enableLocation
                                                              .value
                                                          ? homeController
                                                              .currentLocation!
                                                          : 'Search Live location',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: homeController
                                                                  .enableLocation
                                                                  .value
                                                              ? Colors.white
                                                              : Colors.black),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  homeController
                                                          .locationLoading.value
                                                      ? const SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 3,
                                                            backgroundColor:
                                                                primaryColor,
                                                            color: Colors.grey,
                                                          ),
                                                        )
                                                      : Icon(
                                                          homeController
                                                                  .enableLocation
                                                                  .value
                                                              ? Icons.close
                                                              : Icons
                                                                  .location_searching_rounded,
                                                          color: homeController
                                                                  .enableLocation
                                                                  .value
                                                              ? Colors.white
                                                              : Colors.grey)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          homeController.searchLiveLocations();
                                        },
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          elevation: 5,
                                          child: Container(
                                            height: 50.h,
                                            width: 50.h,
                                            child: Icon(
                                              Icons.location_history_rounded,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 35.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          40.verticalSpace,
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("jobs")
                                  .where("category",
                                      whereIn:
                                          UserService.userModel.serviceCategory)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  homeController.currentJobs.clear();
                                  snapshot.data!.docs.forEach((element) {
                                    JobModel tempJob =
                                        JobModel.fromJson(element.data());
                                    if (homeController.enableLocation.value) {
                                      print("helll0");
                                      double dis = Geolocator.distanceBetween(
                                          tempJob.lat,
                                          tempJob.lng,
                                          homeController
                                              .userCurrentPos!.latitude,
                                          homeController
                                              .userCurrentPos!.longitude);
                                      print(dis / 1000);
                                      if ((dis / 1000) < 10) {
                                        homeController.currentJobs.add(tempJob);
                                      }
                                    } else {
                                      homeController.currentJobs.add(tempJob);
                                    }
                                  });

                                  return SizedBox(
                                    child: Obx(
                                      () => homeController
                                                  .enableLocation.value !=
                                              null
                                          ? GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio: 0.8,
                                                      mainAxisSpacing: 10,
                                                      crossAxisSpacing: 10,
                                                      crossAxisCount: 2),
                                              itemCount: homeController
                                                  .currentJobs.value.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(() => DetailScreen(
                                                          homeController
                                                                  .currentJobs[
                                                              index],
                                                          fromHandyman: true,
                                                        ));
                                                  },
                                                  child: UnconstrainedBox(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.w)),
                                                      height: 220.h,
                                                      width: 0.45.sw,
                                                      child: Column(
                                                        children: [
                                                          Flexible(
                                                            flex: 2,
                                                            child: Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20.w)),
                                                                  child:
                                                                      CommonImageView(
                                                                    url: homeController
                                                                        .currentJobs[
                                                                            index]
                                                                        .images[0],
                                                                    width:
                                                                        0.45.sw,
                                                                    height:
                                                                        140.h,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                    left: 20.w,
                                                                    top: 20.h,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .all(10
                                                                              .h),
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(20.w)),
                                                                      child:
                                                                          Text(
                                                                        homeController
                                                                            .currentJobs[index]
                                                                            .category,
                                                                        style: TextStyle(
                                                                            color:
                                                                                primaryColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 10.sp),
                                                                      ),
                                                                    )),
                                                                Positioned(
                                                                    right: 20.w,
                                                                    bottom:
                                                                        -20.h,
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .all(10
                                                                              .h),
                                                                      decoration: BoxDecoration(
                                                                          color:
                                                                              primaryColor,
                                                                          border: Border.all(
                                                                              color: Colors.white,
                                                                              width: 4),
                                                                          borderRadius: BorderRadius.circular(20.w)),
                                                                      child:
                                                                          Text(
                                                                        '\$${homeController.currentJobs[index].price}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 10.sp),
                                                                      ),
                                                                    ))
                                                              ],
                                                            ),
                                                          ),
                                                          Flexible(
                                                              flex: 1,
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10.w),
                                                                width: 1.sw,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    15.verticalSpace,
                                                                    Text(
                                                                        homeController
                                                                            .currentJobs[
                                                                                index]
                                                                            .title,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 12.sp)),
                                                                    5.verticalSpace,
                                                                    FutureBuilder(
                                                                        future: FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                                "users")
                                                                            .doc(FirebaseAuth
                                                                                .instance.currentUser!.uid)
                                                                            .get(),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            UserModel
                                                                                user =
                                                                                UserModel.fromMap(snapshot.data!.data()!);
                                                                            return Row(
                                                                              children: [
                                                                                Container(
                                                                                  decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: Image.network(user.profileImgUrl ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png").image)),
                                                                                  height: 20.h,
                                                                                  width: 20.w,
                                                                                ),
                                                                                5.horizontalSpace,
                                                                                Text(
                                                                                  user.userName,
                                                                                  style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                                                                                )
                                                                              ],
                                                                            );
                                                                          }
                                                                          return Row(
                                                                            children: [
                                                                              Container(
                                                                                decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: Image.network("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg").image)),
                                                                                height: 20.h,
                                                                                width: 20.w,
                                                                              ),
                                                                              5.horizontalSpace,
                                                                              Text(
                                                                                "Temp user",
                                                                                style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                                                                              )
                                                                            ],
                                                                          );
                                                                        })
                                                                  ],
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                          : SizedBox(),
                                    ),
                                  );
                                }

                                return CircularProgressIndicator(
                                  color: primaryColor,
                                );
                              }),
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              })),
    );
  }
}
