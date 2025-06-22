import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:flutter/material.dart';

class OShadowStyle {
  static final verticalProductSpace = BoxShadow(
    color: MyColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );

  static final horizontalProductShadow = BoxShadow(
     color: MyColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );
}