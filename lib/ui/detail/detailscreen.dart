import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/style/app_sizes.dart';

import '../../global_widgets/busy_button.dart';
import '../../style/colors.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen(this.job,{Key? key}) : super(key: key);
  final JobModel job;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(10.h),
            child: const BusyButton(
              title: 'Book Now',
              isBusy: false,
            ),
          ),
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
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.network(
                                                  "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
                                              .image)));
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
                                itemCount: 5,
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
                                                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
                                                  .image),
                                          borderRadius:
                                              BorderRadius.circular(10.w)),
                                    ),
                                  );
                                }),
                          )),
                      Positioned(
                        bottom: -95.h,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10.w),
                          child: Container(
                            height: 192.h,
                            width: 0.8.sw,
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.job.category,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.grey,
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
                                  "\$ 36.00",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Duration",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "00:26 hours",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                                10.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "0.0",
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30.h,
                        right: 30.w,
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30.h,
                        left: 30.w,
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                            size: 30,
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
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'sdghjdfjsdjfhjdshfksfdgkfsklklfssfsdgfgdsfgdsnmfgdsmnfmnbdgmnbfdgsnmnfbgsnmbfgdfngdsnmfgdnmfgnmdsnmbgfsmnnfmg',
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'Timing',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      '12:00 am',
                      style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kpHorizontalPadding),
                    child: Text(
                      'About Provider',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  5.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(20.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.h),
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: Image.network(
                                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
                                      .image,
                                  fit: BoxFit.cover)),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Demo Provider",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 20.h,
                              child: ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(right: 3.h),
                                      child: Icon(
                                        Icons.star_border_outlined,
                                        color: Theme.of(context).primaryColor,
                                        size: 15.w,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                      ],
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
