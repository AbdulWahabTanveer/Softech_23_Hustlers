import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:softech_hustlers/style/colors.dart';

import 'app_theme.dart';

final TextStyle ts20W800 =
    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w800);
final TextStyle ts16W400 =
    TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);

final TextStyle grey12W400 = TextStyle(
    fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.grey[600]);
final TextStyle ts14w400 = TextStyle(
  fontSize: 14.sp,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.underline,
  fontStyle: FontStyle.italic,
);

final TextStyle appBarTextStyle = TextStyle(
  fontSize: 20.sp,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);

final TextStyle white18w700 = TextStyle(
  fontSize: 18.sp,
  color: Colors.white,
  fontWeight: FontWeight.w700,
);

final TextStyle white18w500 = TextStyle(
  fontSize: 18.sp,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);
final TextStyle white14w500 = TextStyle(
  fontSize: 14.sp,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);
final TextStyle grey14w500 = TextStyle(
  fontSize: 14.sp,
  color: Colors.grey,
  fontWeight: FontWeight.w500,
);
final TextStyle theme16w500 = TextStyle(
  fontSize: 16.sp,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

final TextStyle theme18w500 = TextStyle(
  fontSize: 18.sp,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

final TextStyle theme16w700 = TextStyle(
  fontSize: 16.sp,
  color: primaryColor,
  fontWeight: FontWeight.w700,
);

final TextStyle theme18w700 = TextStyle(
  fontSize: 18.sp,
  color: primaryColor,
  fontWeight: FontWeight.w700,
);

final TextStyle theme14w500 = TextStyle(
  fontSize: 14.sp,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);

final TextStyle theme14w700 = TextStyle(
  fontSize: 14.sp,
  color: primaryColor,
  fontWeight: FontWeight.w700,
);

final TextStyle theme12w500 = TextStyle(
  fontSize: 12.sp,
  color: primaryColor,
  fontWeight: FontWeight.w500,
);
final black14w500 = TextStyle(
  fontSize: 14.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w500,
);

final black16w500 = TextStyle(
  fontSize: 16.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w500,
);

final black18w500 = TextStyle(
  fontSize: 18.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w500,
);

final black18w700 = TextStyle(
  fontSize: 18.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w700,
);

final black16w700 = TextStyle(
  fontSize: 16.sp,
  color: Get.theme.primaryColor == AppTheme.darkTheme.primaryColor
      ? Colors.white
      : Colors.black,
  fontWeight: FontWeight.w700,
);

final black14w700 = TextStyle(
  fontSize: 14.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w700,
);

final black12w700 = TextStyle(
  fontSize: 12.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w700,
);

final black12w500 = TextStyle(
  fontSize: 12.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w500,
);

final black12w400 = TextStyle(
  fontSize: 12.sp,
  color: Get.theme == AppTheme.darkTheme ? Colors.white : Colors.black,
  fontWeight: FontWeight.w400,
);

final appBackgroundColor=Colors.black.withOpacity(0.1);
