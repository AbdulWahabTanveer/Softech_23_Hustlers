import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.controller, required this.validator, required this.label, required this.suffix, required this.hint}) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final Icon suffix;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
        isDense: true,
        labelText: label,
        hintText: hint,
        // suffix: suffix,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r)
        )
      ),
      controller: controller,
    );
  }
}
