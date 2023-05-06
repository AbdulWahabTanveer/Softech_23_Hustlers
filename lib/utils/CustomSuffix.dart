import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSuffix extends StatelessWidget {
  const CustomSuffix(this.suffix,{Key? key}) : super(key: key);
  final IconData suffix;
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(child: FaIcon(suffix,color: Theme.of(context).primaryColor,size: 16.sp,));
  }
}
