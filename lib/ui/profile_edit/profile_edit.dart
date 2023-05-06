import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/global_widgets/custom_text_field.dart';
import 'package:softech_hustlers/services/user_service.dart';
import 'package:softech_hustlers/style/app_sizes.dart';
import 'package:softech_hustlers/ui/map/map.dart';
import 'package:softech_hustlers/ui/profile_edit/profile_edit_controller.dart';

import '../../style/textstyles.dart';

class HandymanProfileEdit extends StatelessWidget {
  HandymanProfileEdit({Key? key}) : super(key: key);
  final ProfileEditController controller = Get.put(ProfileEditController());
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle hintStyle = TextStyle(color: Colors.grey, fontSize: 16.sp);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
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
                                backgroundImage:  NetworkImage(
                                 UserService.userModel.profileImgUrl  ?? 'https://picsum.photos/200/300',
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
                      hintStyle: hintStyle,
                      controller: controller.userNameController,
                      validator: controller.generalValidation,
                      label: "Full Name",
                      hint: "Wahab",
                      suffix: Icon(Icons.person_rounded,color: Theme.of(context).primaryColor,),
                    ),
                    10.verticalSpace,
                    CustomTextField(

                      controller: controller.cnicController,
                      validator: controller.generalValidation,
                      label: "CNIC",
                      hint: "xxxxx-xxxxxxx-x".toUpperCase(),
                      suffix: Icon(FontAwesomeIcons.idCardClip,color: Theme.of(context).primaryColor,),
                      hintStyle: hintStyle,
                    ),
                    10.verticalSpace,
                    CustomTextField(
                      hintStyle: hintStyle,
                      controller: controller.contactNumber,
                      validator: controller.generalValidation,
                      label: "Contact Number",
                      hint: 'Enter Phone No',
                      suffix: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
                    ),
                    20.verticalSpace,
                    CustomTextField(
                      onTap: () async{

                       Map<String,dynamic>? map = await Get.to(()=>const GoogleMapScreen());
                       if(map!=null){
                         Placemark? placeMark = map['address'];
                         controller.position = map['location'];
                         String? name = placeMark!.name;
                         String? subLocality = placeMark.subLocality;
                         String? locality = placeMark.locality;
                         String? administrativeArea = placeMark.administrativeArea;
                         String? postalCode = placeMark.postalCode;
                         String? country = placeMark.country;
                         String? address = "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";


                         controller.location.text = address;

                       }
                      },
                      isDisabled: true,
                      hintStyle: hintStyle,
                      controller: controller.location,
                      validator: controller.generalValidation,
                      label: "Location",
                      hint: "Location",
                      suffix: Icon(Icons.location_on,color: Theme.of(context).primaryColor,),
                    ),
                    20.verticalSpace,
                    Obx(() {
                      return BusyButton(
                        title: "Save Changes",
                        isBusy: controller.isUploading.value,
                        onPressed: () async{
                          if(_key.currentState!.validate()){
                           await controller.updateProfile();
                          }
                        },
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
