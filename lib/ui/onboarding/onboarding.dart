import 'package:clippy_flutter/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../style/colors.dart';
import '../authentication/login/login_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<WalkThroughModelClass> pages = [];
  int currentPosition = 0;
  PageController pageController = PageController();
  final walk_Img1 = "assets/images/Walk_image1.png";
  final walk_Img2 = "assets/images/Walk_image2.png";
  final walk_Img3 = "assets/images/walk_image3.png";
  final walkTitle1 = 'Find your Services';

  final walkTitle2 = 'Book the Appointment';

  final walkTitle3 = 'Payment Gateway';
  final walkThrough1 = "Find a service as per your Preferences.";

  final walkThrough2 = "Book Services on Your Time.";

  final walkThrough3 =
      "Choose the preferable option of payment and get best service.";
  @override
  void initState() {
    super.initState();
    init();

    afterBuildCreated(() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool("FirstTime", true);
      pages.add(WalkThroughModelClass(
          title: walkTitle1, image: walk_Img1, subTitle: walkThrough1));
      pages.add(WalkThroughModelClass(
          title: walkTitle2, image: walk_Img2, subTitle: walkThrough2));
      pages.add(WalkThroughModelClass(
          title: walkTitle3, image: walk_Img3, subTitle: walkThrough3));

      setState(() {});
    });
  }

  init() async {
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Arc(
              arcType: ArcType.CONVEX,
              edge: Edge.TOP,
              height: 50,
              child: Container(
                  height: 1.sh * 0.5,
                  width: 1.sw,
                  color: primaryColor.withOpacity(0.5)),
            ),
          ),
          if (pages.isNotEmpty)
            PageView.builder(
              itemCount: pages.length,
              itemBuilder: (BuildContext context, int index) {
                WalkThroughModelClass page = pages[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    120.verticalSpace,
                    if (page.image != null)
                      Image.asset(page.image!, height: 1.sh * 0.48),
                    16.height,
                    Text(page.title.toString().toUpperCase(),
                        style: boldTextStyle(size: 24, color: white),
                        textAlign: TextAlign.center),
                    16.height,
                    Text(page.subTitle.toString(),
                        style: secondaryTextStyle(color: white),
                        textAlign: TextAlign.center),
                  ],
                ).paddingOnly(left: 8, right: 8);
              },
              controller: pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (num) {
                currentPosition = num + 1;
                setState(() {});
              },
            ),
          Positioned(
            top: 30,
            right: 10,
            child: TextButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setBool("FirstTime", true);
                Get.to(LoginScreen());
              },
              child: Text("Skip", style: boldTextStyle(color: primaryColor)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DotIndicator(
                pageController: pageController,
                pages: pages,
                indicatorColor: primaryColor,
                unselectedIndicatorColor: white,
                currentBoxShape: BoxShape.rectangle,
                boxShape: BoxShape.rectangle,
                borderRadius: radius(2),
                currentBorderRadius: radius(3),
                currentDotSize: 18,
                currentDotWidth: 6,
                dotSize: 6,
              ).paddingBottom(22),
              AppButton(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                text: "Get Started",
                textStyle: boldTextStyle(color: white),
                color: primaryColor,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                onTap: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setBool("FirstTime", false);
                  Get.to(LoginScreen());
                },
              ).visible(currentPosition == 3),
              AppButton(
                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                text: "Next",
                textStyle: boldTextStyle(color: white),
                color: primaryColor,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                onTap: () async {
                  pageController.nextPage(
                      duration: GetNumUtils(500).milliseconds,
                      curve: Curves.linearToEaseOut);
                },
              ).visible(currentPosition < 3),
            ],
          ).paddingBottom(60),
        ],
      ),
    );
  }
}
