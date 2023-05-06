import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/ui/profile_edit/profile_edit_controller.dart';

import '../../style/textstyles.dart';

class HandymanProfileEdit extends StatelessWidget {
  HandymanProfileEdit({Key? key}) : super(key: key);
  final controller = Get.put(ProfileEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() => HandymanProfileEdit());
              },
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    20.verticalSpace,
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundImage: const NetworkImage(
                              'https://picsum.photos/200/300',
                            ),
                          ),
                          Positioned(
                              right: 2.w,
                              bottom: -6.h,
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                                child: const FaIcon(
                                  FontAwesomeIcons.camera,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    CustomTextField(
                        controller: controller.fname,
                        validator: (val) {
                          return "";
                        },
                        label: "First Name",
                        hint: "Wahab"),
                    10.verticalSpace,
                    CustomTextField(
                        controller: controller.lname,
                        validator: (val) {
                          return "";
                        },
                        label: "Last Name",
                        hint: "Demo"),
                    10.verticalSpace,
                    CustomTextField(
                        controller: controller.uname,
                        validator: (val) {
                          return "";
                        },
                        label: "User Name",
                        hint: "saifr383"),
                    10.verticalSpace,
                    CustomTextField(
                        controller: controller.cnic,
                        validator: (val) {
                          return "";
                        },
                        label: "Cnic",
                        hint: "3730166219939"),
                    10.verticalSpace,
                    CustomTextField(
                        controller: controller.contactNumber,
                        validator: (val) {
                          return "";
                        },
                        label: "Contact Number",
                        hint: "03110459312"),
                    20.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05)),
                      height: 50.h,
                      width: double.infinity,
                      child: const Center(
                          child: Text(
                        "Add Location",
                      )),
                    ),
                    20.verticalSpace,
                    Obx(() {
                      return BusyButton(
                        title: "Save Changes",
                        isBusy: controller.isUploading.value,
                        onPressed: () {},
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
