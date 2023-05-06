import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_dropdown.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/ui/map/map.dart';
import 'package:softech_hustlers/utils/CustomSuffix.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import '../../global_widgets/services_category_dropdown.dart';
import 'add_new_job_controller.dart';

class AddNewJob extends StatelessWidget {
  AddNewJob({Key? key}) : super(key: key);
  final controller = Get.put(AddNewJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Job")),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding.w),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  20.verticalSpace,
                  CustomTextField(
                    controller: controller.jobTitle,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job title";
                      } else {
                        return null;
                      }
                    },
                    label: "Job title",
                    hint: "Job title",
                    suffix: const CustomSuffix(FontAwesomeIcons.briefcase),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.jobDescription,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job description";
                      } else {
                        return null;
                      }
                    },
                    label: "Job Description",
                    hint: "Job Description",
                    suffix: const CustomSuffix(FontAwesome.clipboard),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.price,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job price";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                    label: "Price in dollars",
                    hint: "Price in dollars",
                    suffix: const CustomSuffix(FontAwesome.money),
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.date,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job date";
                      } else {
                        return null;
                      }
                    },
                    label: "Date",
                    hint: "Date",
                    suffix: const CustomSuffix(FontAwesome.calendar),
                    isDisabled: true,
                    onTap: () {
                      controller.pickDate(context);
                    },
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.time,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please enter job time";
                      } else {
                        return null;
                      }
                    },
                    label: "Time",
                    hint: "Time",
                    suffix: const CustomSuffix(FontAwesome.clock_o),
                    isDisabled: true,
                    onTap: () {
                      controller.pickTime(context);
                    },
                  ),
                  10.verticalSpace,
                  ServiceCategoryDropdown(
                    onChange: (String v) {
                      controller.selectedCategory.value = v;
                    },
                    value: controller.selectedCategory.value,
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.location,
                    validator: (val) {
                      if (val != null && val.isEmpty) {
                        return "Please select location";
                      } else {
                        return null;
                      }
                    },
                    label: "Location",
                    hint: "Location",
                    suffix: const CustomSuffix(FontAwesome.location_arrow),
                    isDisabled: true,
                    onTap: () async {
                      controller.ontapLocation();
                    },
                  ),
                  10.verticalSpace,
                  CustomTextField(
                    controller: controller.picture,
                    validator: (val) {
                      if (controller.jobImages.isNotEmpty) {
                        return null;
                      } else {
                        return "Please enter atleast 1 image";
                      }
                    },
                    label: "Add Picture",
                    hint: "Press here to add picture",
                    suffix: const CustomSuffix(
                      FontAwesome.camera,
                    ),
                    isDisabled: true,
                    onTap: () {
                      controller.pickImage();
                    },
                  ),
                  10.verticalSpace,
                  Obx(() {
                    return controller.jobImages.value.isEmpty
                        ? Container(
                            height: 20.h,
                          )
                        : SizedBox(
                            height: 100.h,
                            width: 1.sw,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.jobImages.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: 12.w, bottom: 10.h),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.w),
                                          child: CommonImageView(
                                            file: File(controller
                                                .jobImages[index].path),
                                            width: 100.w,
                                          ),
                                        ),
                                        Positioned(
                                            top: 10.h,
                                            right: 10.w,
                                            child: InkWell(
                                              onTap: () {
                                                controller.jobImages
                                                    .removeAt(index);
                                              },
                                              child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  )),
                                            ))
                                      ],
                                    ),
                                  );
                                }),
                          );
                  }),
                  Obx(() {
                    return BusyButton(
                      title: "Add Job",
                      isBusy: controller.isBusy.value,
                      onPressed: () {
                        controller.addJob();
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
