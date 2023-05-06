import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

InputDecoration inputDecoration(BuildContext context, {String? hint, Widget? prefixIcon}) {
  return InputDecoration(
    labelStyle: TextStyle(color: Theme.of(context).textTheme.titleLarge!.color),
    contentPadding: EdgeInsets.all(8),
    hintText: hint,
    hintStyle: secondaryTextStyle(),
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: viewLineColor, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(defaultRadius),
      borderSide: BorderSide(color: primaryColor, width: 1.0),
    ),
  );
}
