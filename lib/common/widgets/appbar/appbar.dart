import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/utils/device/device_utility.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Color color;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final double height;
  
  const AppBarWidget({super.key, 
   this.title, 
   this.color= Colors.transparent,
   this.showBackArrow = false, 
   this.leadingIcon, 
   this.actions, 
   this.leadingOnPressed,
   this.height = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: color,
      leading: showBackArrow 
      ? IconButton(onPressed: ()=> Get.back(), icon: IconButton(
          onPressed: ()=> Get.back(), 
          icon: Image.asset(
            AssetsManager.iconArrowBack,
            color: Colors.white,
            width: 100,
          ),
        )) 
      : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon)) : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    height == 0 
      ? TDeviceUtility.getAppBarHeight()
      : height
  );
}