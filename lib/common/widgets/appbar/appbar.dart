import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/device/device_utility.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color color;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  const AppBarWidget({super.key, 
   this.title, 
   this.color= Colors.transparent,
   this.showBackArrow = false, 
   this.leadingIcon, 
   this.actions, 
   this.leadingOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: color,
      leading: showBackArrow 
      ? IconButton(onPressed: ()=> Get.back(), icon: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Iconsax.arrow_left),
      )) 
      : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtility.getAppBarHeight());
}