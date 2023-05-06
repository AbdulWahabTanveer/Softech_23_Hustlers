import 'package:flutter/material.dart';
import 'package:softech_hustlers/global_widgets/custom_dropdown.dart';
import 'package:softech_hustlers/utils/utils.dart';

class ServiceCategoryDropdown extends StatelessWidget {
  const ServiceCategoryDropdown({Key? key,required this.onChange, this.value}) : super(key: key);

  final void Function(String) onChange;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownSelect(dropdownItems: servicesCategories, onChange: onChange, label: 'Service Category', value: value,
      hint: "Select service category",
    );
  }
}
