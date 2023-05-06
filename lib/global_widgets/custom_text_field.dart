import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.controller, required this.validator, required this.label, this.suffix, required this.hint}) : super(key: key);
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String label;
  final Icon? suffix;
  final String hint;
  final bool hideText;

  @override
  Widget build(BuildContext context) {

    OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(width: 0,color: Colors.transparent )
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
        8.verticalSpace,
        TextFormField(
          obscureText: hideText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
            isDense: false,
            fillColor:
            Theme.of(context).primaryColor.withOpacity(0.05) ,
            filled: true,
            // labelText: label,
            hintText: hint,
            // suffix: suffix,
            suffixIcon: suffix,
            border: border ,
            focusedBorder: border,
            enabledBorder: border,
            errorBorder: border,

          ),
          controller: controller,
        ),
      ],
    );
  }
}
