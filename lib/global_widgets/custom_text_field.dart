import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  }) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final suffix;
  final String hint;
  final Function? onTap;
  final bool isDisabled;
  final bool hideText;

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
              color: Theme.of(context).primaryColor,
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
                  enabled: isDisabled,
                  readOnly: isDisabled,
                  onTap: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    isDense: false,
                    fillColor: true
                        ? Theme.of(context).primaryColor.withOpacity(0.05)
                        : Colors.grey.withOpacity(0.1),
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
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                  isDense: false,
                  fillColor: true
                      ? Theme.of(context).primaryColor.withOpacity(0.05)
                      : Colors.grey.withOpacity(0.1),
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
      ],
    );
  }
}
