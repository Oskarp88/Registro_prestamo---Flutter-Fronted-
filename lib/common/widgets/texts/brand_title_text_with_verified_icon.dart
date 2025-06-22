import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/widgets/texts/brand_title_text.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/constants/enums.dart';
import 'package:prestapp/utils/constants/my_colors.dart';

class BrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const BrandTitleTextWithVerifiedIcon({
    super.key, 
    required this.title, 
    this.maxLines = 1, 
    this.textColor, 
    this.iconColor = MyColors.primaryColor, 
    this.textAlign = TextAlign.center, 
    this.brandTextSizes = TextSizes.small
  });
  
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign textAlign;
  final TextSizes brandTextSizes;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: BrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            branTextSizes: brandTextSizes,
          )
        ),
        const SizedBox(height: Dimensions.xs),
        Icon(Iconsax.verify5, color: iconColor, size: Dimensions.iconXs)
      ],
    );
  }
}