import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomDropdownSelect extends StatelessWidget {
  const CustomDropdownSelect({
    super.key,
    this.value,
    required this.dropdownItems,
    required this.onChange,
    this.hint = 'Select reason...',
    this.borderColor = Colors.black12,
    required this.label,
    this.validator
  });

  final String? value;
  final List<String> dropdownItems;
  final String hint;
  final Color borderColor;
  final String label;
  final String? Function(String? value)? validator;

  final void Function(String value) onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),),
        5.verticalSpace,

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            // border: Border.all(color: borderColor.withOpacity(0.2)),
            color: Colors.green.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
              validator: validator,
              decoration: const InputDecoration(
                border: InputBorder.none
              ),
              elevation: 1,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              value: value,
              isExpanded: true,
              hint: Text(
                hint,
                // style: TextStyle(fontSize: 16),
                textAlign: TextAlign.start,
              ),
              items: dropdownItems.map((reason) {
                return DropdownMenuItem(
                  value: reason,
                  child: Text(
                    reason,
                    // style: const TextStyle(color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                );
              }).toList(),
              onChanged: (value) => onChange(value.toString()),
            ),
          ),
        ),
      ],
    );
  }
}
