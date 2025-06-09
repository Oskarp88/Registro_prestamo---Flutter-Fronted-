import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class VerticalImageText extends StatelessWidget {
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  
  const VerticalImageText({
    super.key, 
    required this.image, 
    required this.title, 
    this.textColor = Colors.white, 
    this.backgroundColor = Colors.white, 
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: Dimensions.spaceBtwItems),
        child: Column(
          children: [
             ///Circular Icon
             Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(Dimensions.sm),
              decoration: BoxDecoration(
                color: backgroundColor ?? (THelperFuntions.isDarkMode(context) ? MyColors.black : MyColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
             ),
             ///text
             const SizedBox(height: Dimensions.spaceBtwItems / 2), 
             SizedBox(
              width: 55,
               child: Text(
                 title,
                 style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
               ),
             )
          ],
        ),
      ),
    );
  }
}

