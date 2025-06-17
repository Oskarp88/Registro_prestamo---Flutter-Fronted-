import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/device/device_utility.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class SearchContainer extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onChanged;

  const SearchContainer({
    super.key,
    required this.hintText,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: Dimensions.defaultSpace),
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuntions.isDarkMode(context);

    return Padding(
      padding: padding,
      child: Container(
        width: TDeviceUtility.getScreenWidth(context),
        decoration: BoxDecoration(
          color: showBackground ? (dark ? MyColors.dark : MyColors.light) : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.cardRadiusLg),
          border: showBorder ? Border.all(color: MyColors.grey) : null,
        ),
        child: TextField(
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: dark ? MyColors.white : MyColors.darkGrey),
            hintText: hintText,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14)
          ),
        ),
      ),
    );
  }
}
