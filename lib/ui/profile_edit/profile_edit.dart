import 'dart:io';

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
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.verticalSpace,
                  Center(
                    child: InkWell(
                      onTap: (){
                        controller.pickImage();
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(() {
                            return CircleAvatar(
                              radius: 60.r,
                              backgroundImage: const NetworkImage(
                                'https://picsum.photos/200/300',
                              ),
                              foregroundImage: controller.profilePic.value !=
                                      null
                                  ? MemoryImage(
                                      File(controller.profilePic.value!.path)
                                          .readAsBytesSync())
                                  : null,
                            );
                          }),
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
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: controller.fname,
                    validator: (val) {
                      return "";
                    },
                    label: "First Name",
                    hint: "Wahab",
                    suffix: Icon(Icons.person_outline_rounded,color: Theme.of(context).primaryColor,),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.lname,
                    validator: (val) {
                      return "";
                    },
                    label: "Last Name",
                    hint: "Demo",
                    suffix: Icon(Icons.person_outline_rounded,color: Theme.of(context).primaryColor,),

                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.uname,
                    validator: (val) {
                      return "";
                    },
                    label: "User Name",
                    hint: "saifr383",
                    suffix: Icon(Icons.person_outline_rounded,color: Theme.of(context).primaryColor,),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.cnic,
                    validator: (val) {
                      return "";
                    },
                    label: "Cnic",
                    hint: "3730166219939",
                    suffix: Icon(Icons.person_add_outlined,color: Theme.of(context).primaryColor,),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.contactNumber,
                    validator: (val) {
                      return "";
                    },
                    label: "Contact Number",
                    hint: "03110459312",
                    suffix: Icon(Icons.phone_enabled_outlined,color: Theme.of(context).primaryColor,),
                  ),
                  20.verticalSpace,
                  CustomTextField(
                    controller: controller.location,
                    validator: (val) {
                      return "";
                    },
                    label: "Location",
                    hint: "Location",
                    suffix: Icon(Icons.location_on_outlined,color: Theme.of(context).primaryColor,),
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
          ],
        ),
      ),
    );
  }
}
