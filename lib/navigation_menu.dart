import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/gestion_de_fondos.dart';
import 'package:registro_prestamos/feactures/pages/screens/home/home.dart';
import 'package:registro_prestamos/feactures/personalization/screens/settings/settings.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFuntions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: darkMode ? MyColors.black : MyColors.white5,
          indicatorColor: darkMode ? MyColors.white.withValues(alpha: 0.1) : MyColors.black.withValues(alpha: 0.1),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
           NavigationDestination(
            icon: Icon(Iconsax.home), 
            label: 'Home'
           ),
           NavigationDestination(
            icon: Icon(Iconsax.money_send), 
            label: 'Gestión'
           ),
          //  NavigationDestination(
          //   icon: Icon(Iconsax.heart), 
          //   label: 'Wishlist'
          //  ),
           NavigationDestination(
            icon: Icon(Iconsax.user), 
            label: 'Profile'
           )         
          ]
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const GestionDeFondos(),
    // const Wishlist(),
    const SettingsScreen(),
  ];
}