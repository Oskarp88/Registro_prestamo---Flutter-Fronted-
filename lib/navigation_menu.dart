// lib/feactures/pages/navigation_menu.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/gestion_de_fondos.dart';
import 'package:registro_prestamos/feactures/pages/screens/home/home.dart';
import 'package:registro_prestamos/feactures/pages/screens/notifications/notifications_screen.dart';
import 'package:registro_prestamos/feactures/personalization/screens/settings/settings.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/provider/notification_provider.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final notifProvider = AuthenticateProvider.instance.notificationsProvider!;

    return ChangeNotifierProvider.value(
      value: notifProvider,
      child: const NavigationMenuContent(),
    );
  }
}

class NavigationMenuContent extends StatelessWidget {
  const NavigationMenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFuntions.isDarkMode(context);
    final notifProvider = Provider.of<ProviderNotifications>(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: darkMode ? MyColors.black : MyColors.white5,
          indicatorColor: darkMode ? MyColors.white.withAlpha(25) : MyColors.black.withAlpha(25),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: [
            const NavigationDestination(
              icon: Icon(Iconsax.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Iconsax.money_send),
              label: 'Gestión',
            ),
            NavigationDestination(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Iconsax.notification),
                  if (notifProvider.unreadCount > 0)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                        child: Text(
                          '${notifProvider.unreadCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Notificaciones',
            ),
            const NavigationDestination(
              icon: Icon(Iconsax.user),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    const HomeScreen(),
    const GestionDeFondos(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];
}
