import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../style/app_theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.label,
    this.suffix,
    required this.hint,
    this.onTap,
    this.isDisabled = false,
    this.hideText = false,
    this.hintStyle,
    this.keyboardType,
    this.inputFormat,
  }) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final suffix;
  final String hint;
  final Function? onTap;
  final bool isDisabled;
  final TextStyle? hintStyle;
  final bool hideText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormat;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(width: 0, color: Colors.transparent));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
              color: Get.theme.primaryColor ==
                  AppTheme.darkTheme.primaryColor
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        5.verticalSpace,
        isDisabled
            ? InkWell(
                onTap: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: TextFormField(
                  validator: validator,
                  enabled: isDisabled,
                  readOnly: isDisabled,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormat,
                  onTap: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    isDense: false,
                    fillColor: Get.theme.primaryColor ==
                            AppTheme.darkTheme.primaryColor
                        ? Colors.white
                        : Theme.of(context).primaryColor.withOpacity(0.05),

                    filled: true,
                    // labelText: label,
                    hintText: hint,
                    // suffix: suffix,
                    suffixIcon: suffix,
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    disabledBorder: border,
                  ),
                  controller: controller,
                ),
              )
            : TextFormField(
                obscureText: hideText,
                validator: validator,
                keyboardType: keyboardType,
                inputFormatters: inputFormat,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  isDense: false,
                  fillColor: Get.theme.primaryColor ==
                      AppTheme.darkTheme.primaryColor
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(0.05),
                  filled: true,
                  // labelText: label,
                  hintText: hint,
                  hintStyle: hintStyle,
                  // suffix: suffix,
                  suffixIcon: suffix,
                  border: border,
                  focusedBorder: border,
                  enabledBorder: border,
                  disabledBorder: border,
                  errorBorder: border,
                  focusedErrorBorder: border,
                ),
                controller: controller,
              ),
      ],
    );
  }
}
