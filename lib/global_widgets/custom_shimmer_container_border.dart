import 'package:flutter/material.dart';

class CustomShimmerBorderedContainer extends StatelessWidget {
  const CustomShimmerBorderedContainer({Key? key,  this.child,this.height, this.width, this.shape }) : super(key: key);

  final Widget? child;
  final double? height;
  final double? width;
  final BoxShape? shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.rectangle,
          color: Colors.white,
          borderRadius: shape ==null ?  BorderRadius.circular(3) : null
      ),
      child: child,
    );

  }
}
