import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:softech_hustlers/style/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;

  @override
  Widget build(BuildContext context) {
    print("Hhh");
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: 1.sh,
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        height: 300.0,
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
                      bottom: 30.h,
                      child: SizedBox(
                        height: 30.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return UnconstrainedBox(
                                child: Container(
                                  margin: EdgeInsets.only(right: 5.h),
                                  height: 8.h,
                                  width: index == currentSlider ? 15.h : 8.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.w)),
                                ),
                              );
                            }),
                      )),
                  Positioned(
                      bottom: -25.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10.w),
                            child: Container(
                              height: 50.h,
                              width: 0.7.sw,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                  ),
                                  20.horizontalSpace,
                                  const Text(
                                    'Search for a location',
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.location_searching_rounded,
                                      color: Colors.grey)
                                ],
                              ),
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10.w),
                            elevation: 5,
                            child: Container(
                              height: 50.h,
                              width: 50.h,
                              child: Icon(
                                Fontisto.search,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              40.verticalSpace,
              SizedBox(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.8,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return UnconstrainedBox(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20.w)),
                          height: 220.h,
                          width: 0.45.sw,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.w)),
                                      child: Image.network(
                                        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
                                        fit: BoxFit.cover,
                                        height: 170.h,
                                      ),
                                    ),
                                    Positioned(
                                        left: 20.w,
                                        top: 20.h,
                                        child: Container(
                                          padding: EdgeInsets.all(10.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.w)),
                                          child: Text(
                                            'LAUNDRY',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.sp),
                                          ),
                                        )),
                                    Positioned(
                                        right: 20.w,
                                        bottom: -20.h,
                                        child: Container(
                                          padding: EdgeInsets.all(10.h),
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 4),
                                              borderRadius:
                                                  BorderRadius.circular(20.w)),
                                          child: Text(
                                            '\$36.00',
                                            style: TextStyle(
                                                color: Colors.white,
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    width: 1.sw,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        5.verticalSpace,
                                        Container(
                                          height: 20.h,
                                          child: ListView.builder(
                                              itemCount: 5,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 3.h),
                                                  child: Icon(
                                                    Icons.star_border_outlined,
                                                    color: Colors.grey,
                                                    size: 15.w,
                                                  ),
                                                );
                                              }),
                                        ),
                                        Text("Dry Cleaning",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp)),
                                        5.verticalSpace,
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: Image.network(
                                                              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg")
                                                          .image)),
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                            5.horizontalSpace,
                                            Text(
                                              "Temp user",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.sp),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
