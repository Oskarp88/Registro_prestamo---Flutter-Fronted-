import 'package:flutter/material.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/constants/my_colors.dart';

class RoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const RoundedContainer({
    super.key, 
    this.width, 
    this.height, 
    this.radius = Dimensions.cardRadiusLg, 
    this.child, 
    this.showBorder = false, 
    this.borderColor = MyColors.borderPrimary, 
    this.backgroundColor = MyColors.white, 
    this.padding, 
    this.margin
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}