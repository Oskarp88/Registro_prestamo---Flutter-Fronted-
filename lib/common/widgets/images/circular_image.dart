import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key, 
    this.fit = BoxFit.cover, 
    required this.image, 
    this.isNetworkImage = false, 
    this.overLayColor, 
    this.backgroundColor, 
    this.width = 56, 
    this.height = 56, 
    this.padding = Dimensions.sm, 
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overLayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (THelperFuntions.isDarkMode(context) ? MyColors.black : MyColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        fit: fit,
        image: isNetworkImage ? AssetImage(image) : AssetImage(image) as ImageProvider,
        color: overLayColor
      ),
    );
  }
}