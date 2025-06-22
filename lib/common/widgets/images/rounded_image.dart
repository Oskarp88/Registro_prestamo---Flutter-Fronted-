import 'package:flutter/material.dart';
import 'package:prestapp/utils/constants/dimensions.dart';

class RoundedImage extends StatelessWidget {
   final double? width, height;
   final String imagenUrl;
   final bool applyImagenRadius;
   final BoxBorder? border;
   final Color? backgroundColor;
   final BoxFit? fit;
   final EdgeInsetsGeometry? padding;
   final bool isNetworkImage;
   final VoidCallback? onPressed;
   final double borderRadius;
   
  const RoundedImage({
    super.key, 
    this.width, 
    this.height, 
    required this.imagenUrl,  
    this.applyImagenRadius = true, 
    this.border, 
    this.backgroundColor, 
    this.fit = BoxFit.contain, 
    this.padding, 
    this.isNetworkImage = false, 
    this.onPressed, 
    this.borderRadius = Dimensions.md,  
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
       decoration: BoxDecoration(
         border: border,
         color: backgroundColor,
         borderRadius: BorderRadius.circular(borderRadius)
       ),
       child:  ClipRRect(
         borderRadius: applyImagenRadius ?  BorderRadius.circular(borderRadius) : BorderRadius.zero,
         child: Image(
           image: isNetworkImage ? NetworkImage(imagenUrl) : AssetImage(imagenUrl) as ImageProvider,
           fit: fit,
           ),
       ),
      ),
    );
  }
}

