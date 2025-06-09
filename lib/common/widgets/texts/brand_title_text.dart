import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/constants/enums.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText({
    super.key, 
    this.color, 
    required this.title, 
    this.maxLines = 1, 
    this.textAlign = TextAlign.center, 
    this.branTextSizes = TextSizes.small
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes branTextSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: branTextSizes == TextSizes.small
         ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
         : branTextSizes == TextSizes.medium
            ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
            : branTextSizes == TextSizes.large
              ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
              : Theme.of(context).textTheme.bodyMedium!.apply(color: color),
               
    );
  }
}