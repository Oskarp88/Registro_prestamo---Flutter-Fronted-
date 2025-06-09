import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/device/device_utility.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class SearchContainer extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  const SearchContainer({
    super.key, 
    required this.text, 
    this.icon = Iconsax.search_normal, 
    this.showBackground = true, 
    this.showBorder= true, 
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: Dimensions.defaultSpace),
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuntions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: TDeviceUtility.getScreenWidth(context),
          padding: const EdgeInsets.all(Dimensions.md),
          decoration: BoxDecoration(
            color: showBackground ? dark ? MyColors.dark : MyColors.light : Colors.transparent, 
            borderRadius: BorderRadius.circular(Dimensions.cardRadiusLg),
            border: showBorder ? Border.all(color: MyColors.grey,) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: MyColors.darkGrey),
              const SizedBox(width: Dimensions.spaceBtwItems),
              Text(
                 text,
                 style: Theme.of(context).textTheme.bodySmall, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}

