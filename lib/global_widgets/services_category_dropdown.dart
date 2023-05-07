import 'package:flutter/material.dart';
import 'package:softech_hustlers/global_widgets/custom_dropdown.dart';
import 'package:softech_hustlers/utils/utils.dart';

class ServiceCategoryDropdown extends StatelessWidget {
  ServiceCategoryDropdown(
      {Key? key, required this.onChange, this.value, this.delete})
      : super(key: key);

  final void Function(String) onChange;
  final String? value;
  List<String>? delete;

  @override
  Widget build(BuildContext context) {
    List<String> temp = List.from(servicesCategories);
    temp.removeWhere(
        (element) => delete == null ? false : delete!.contains(element));
    return CustomDropdownSelect(
      dropdownItems: temp,
      onChange: onChange,
      label: 'Service Category',
      value: value,
      hint: "Select service category",
    );
  }
}
