import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/utils/CustomSuffix.dart';
import 'package:softech_hustlers/utils/common_image_view.dart';

import 'add_new_job_controller.dart';

class AddNewJob extends StatelessWidget {
  AddNewJob({Key? key}) : super(key: key);
  final controller = Get.put(AddNewJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Job")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
          child: Column(
            children: [
              20.verticalSpace,
              CustomTextField(
                controller: controller.jobTitle,
                validator: (val) {
                  return "";
                },
                label: "Job title",
                hint: "Job title",
                suffix: CustomSuffix(FontAwesomeIcons.briefcase),
              ),
              10.verticalSpace,
              CustomTextField(
                controller: controller.jobDescription,
                validator: (val) {
                  return "";
                },
                label: "Job Description",
                hint: "Job Description",
                suffix: CustomSuffix(FontAwesome.clipboard),
              ),
              10.verticalSpace,
              CustomTextField(
                controller: controller.price,
                validator: (val) {
                  return "";
                },
                label: "Price",
                hint: "Price",
                suffix: CustomSuffix(FontAwesome.money),
              ),
              10.verticalSpace,
              CustomTextField(
                controller: controller.price,
                validator: (val) {
                  return "";
                },
                label: "Date",
                hint: "Date",
                suffix: CustomSuffix(FontAwesome.calendar),
              ),
              10.verticalSpace,
              CustomTextField(
                controller: controller.price,
                validator: (val) {
                  return "";
                },
                label: "Time",
                hint: "Time",
                suffix: CustomSuffix(FontAwesome.clock_o),
                isDisabled: true,
                onTap: (){
                  
                },
              ),
              10.verticalSpace,
              CustomTextField(
                controller: controller.price,
                validator: (val) {
                  return "";
                },
                label: "Add Picture",
                hint: "Press here to add picture",
                suffix: const CustomSuffix(
                  FontAwesome.camera,
                ),
                isDisabled: true,
                onTap: (){
                  controller.pickImage();
                },
              ),
            ],
          ),
        ),
      ),

      //pic date time picker icons type drop down
    );
  }
}
