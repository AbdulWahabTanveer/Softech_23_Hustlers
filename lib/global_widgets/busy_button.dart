import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusyButton extends StatelessWidget {
  const BusyButton({Key? key, required this.title, this.onPressed, required this.isBusy}) : super(key: key);

  final String title;
  final void Function()? onPressed;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return
      isBusy ? const SizedBox(
        height: 40,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :
      InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).primaryColor
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18.sp,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
