import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/models/job_model.dart';
import 'package:softech_hustlers/style/app_sizes.dart';

import '../../global_widgets/busy_button.dart';
import '../../global_widgets/custom_text_field.dart';
import '../../models/bid_model.dart';
import '../../models/user_model.dart';
import '../../style/app_theme.dart';
import '../../style/colors.dart';
import 'dialogcontroller.dart';

class DetailScreen extends StatefulWidget {
  final bool fromHandyman;
  const DetailScreen(this.job, {Key? key, this.fromHandyman = false})
      : super(key: key);
  final JobModel job;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int currentSlider = 0;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  DialogController con = Get.put(DialogController());

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
          bottomNavigationBar: widget.fromHandyman
              ? Padding(
                  padding: EdgeInsets.all(10.h),
                  child: BusyButton(
                    title: 'Bid Now',
                    isBusy: false,
                    onPressed: () {
                      TextEditingController newBid = TextEditingController();
                      Get.defaultDialog(
                          contentPadding: EdgeInsets.all(15.h),
                          title: "Bid Now",
                          content: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("bids")
                                  .where("jobId", isEqualTo: widget.job.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  double amount = 0;

                                  snapshot.data!.docs.forEach((element) {
                                    Bid bid = Bid.fromMap(element.data());
                                    if (bid.handymanId ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      con.alreadyExist = true;
                                    }
                                    if (amount > bid.amount) {
                                      amount = bid.amount;
                                    }
                                  });

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      10.verticalSpace,
                                      Form(
                                        key: form,
                                        child: CustomTextField(
                                          controller: newBid,
                                          validator: (value) {
                                            if (con.alreadyExist) {
                                              return "You cannot Bid twice";
                                            }
                                            if (value == "") {
                                              return "Bid cannot be empty";
                                            }

                                            if (double.parse(newBid.text) >
                                                amount) {
                                              return "Amount Cannot Be More than previous bid";
                                            }

                                            return null;
                                          },
                                          label: 'Bid Amount:',
                                          hint: '10.0',
                                        ),
                                      ),
                                      10.verticalSpace,
                                      Text(
                                        "Highest Bid:\$$amount",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 16),
                                      ),
                                      10.verticalSpace,
                                      Obx(
                                        () => BusyButton(
                                          title: 'Bid',
                                          isBusy: con.loading.value,
                                          onPressed: () async {
                                            print("ssss");
                                            if (form.currentState!.validate()) {
                                              con.loading.value = true;

                                              await FirebaseFirestore.instance
                                                  .collection("bids")
                                                  .add(Bid(
                                                          accepted: false,
                                                          amount: double.parse(
                                                              newBid.text),
                                                          customerId:
                                                              widget.job.uid,
                                                          handymanId:
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                          jobId: widget.job.id,
                                                          id: '',
                                                          rejected: false)
                                                      .toMap());
                                              con.loading.value = false;
                                              Get.back();
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                  ),
                                );
                              }));
                    },
                  ),
                )
              : SizedBox(),
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
                            height: 130.h,
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
                                  "\$ ${widget.job.price}",
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
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
                          width: 34.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
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
                          color:  Get.theme.primaryColor ==
                      AppTheme.darkTheme.primaryColor
                      ? Colors.white:
                          Colors.black,
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
                          color:  Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor
                              ? Colors.white:
                          Colors.black,
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
                      'About Provider',
                      style: TextStyle(
                          color:  Get.theme.primaryColor ==
                              AppTheme.darkTheme.primaryColor
                              ? Colors.white:
                          Colors.black,                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  10.verticalSpace,
                  Container(
                    padding: EdgeInsets.all(20.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.h),
                      color:  Get.theme.primaryColor ==
                          AppTheme.darkTheme.primaryColor
                          ? Colors.white:
                      Theme.of(context).primaryColor.withOpacity(0.05),
                    ),
                    child: FutureBuilder<UserModel>(
                        future: getUser(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error something went wrong");
                          } else if (snapshot.hasData) {
                            return Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: Image.network(
                                                  snapshot.data!.profileImgUrl!)
                                              .image,
                                          fit: BoxFit.cover)),
                                ),
                                10.horizontalSpace,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.userName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    widget.fromHandyman
                                        ? SizedBox()
                                        : Container(
                                            height: 20.h,
                                            child: ListView.builder(
                                                itemCount: 5,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 3.h),
                                                    child: Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: 15.w,
                                                    ),
                                                  );
                                                }),
                                          ),
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                  20.verticalSpace,
                ],
              ),
            ),
          )),
    );
  }
}
