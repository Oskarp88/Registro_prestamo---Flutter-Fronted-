import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/gestion_de_fondos.dart';
import 'package:prestapp/feactures/pages/screens/home/home.dart';
import 'package:prestapp/feactures/pages/screens/notifications/notifications_screen.dart';
import 'package:prestapp/feactures/personalization/screens/settings/settings.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:provider/provider.dart';

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

class NavigationMenuContent extends StatefulWidget {
  const NavigationMenuContent({super.key});

  @override
  State<NavigationMenuContent> createState() => _NavigationMenuContentState();
}

class _NavigationMenuContentState extends State<NavigationMenuContent> {
  late final bool isAdmin;
  late final NavigationController controller;
  late final List<NavigationDestination> navDestinations;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    isAdmin = context.read<AuthenticateProvider>().user!.isAdmin;

    // Crear lista de pantallas y menús sincronizados
    screens = [
      const HomeScreen(),
      if (isAdmin) const GestionDeFondos(),
      const NotificationScreen(),
      const SettingsScreen(),
    ];

    navDestinations = [
      const NavigationDestination(
        icon: Icon(Iconsax.home),
        label: 'Home',
      ),
      if (isAdmin)
        const NavigationDestination(
          icon: Icon(Iconsax.money_send),
          label: 'Gestión',
        ),
      NavigationDestination(
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Iconsax.notification),
            if (AuthenticateProvider.instance.notificationsProvider!.unreadCount > 0)
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
                    '${AuthenticateProvider.instance.notificationsProvider!.unreadCount}',
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
        label: 'Perfil',
      ),
    ];

    controller = Get.put(NavigationController(screens));
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFuntions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          backgroundColor: darkMode ? MyColors.black : MyColors.white5,
          indicatorColor: darkMode ? MyColors.white.withAlpha(25) : MyColors.black.withAlpha(25),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: navDestinations,
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final List<Widget> screens;

  NavigationController(this.screens);
}
