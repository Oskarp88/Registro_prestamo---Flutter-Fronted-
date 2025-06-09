import 'package:flutter/material.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/device/device_utility.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class TabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TabBarWidget({
    super.key,      
    required this.tabs,
  });

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuntions.isDarkMode(context);
    return Material(
      color: dark ? MyColors.black : MyColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: MyColors.primaryColor,
        unselectedLabelColor: MyColors.darkGrey,
        labelColor: dark ? MyColors.white : MyColors.primaryColor,
        
      ),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtility.getAppBarHeight());
}