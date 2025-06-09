import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: Dimensions.appBarheight,
      left: Dimensions.defaultSpace,
      bottom: Dimensions.defaultSpace,
      right: Dimensions.defaultSpace,
  );
}