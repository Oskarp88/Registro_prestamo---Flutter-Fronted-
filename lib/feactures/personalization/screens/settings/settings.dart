import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/common/widgets/list_title/settings_menu_title.dart';
import 'package:registro_prestamos/common/widgets/list_title/user_profile_title.dart';
import 'package:registro_prestamos/common/widgets/texts/section_headig.dart';
import 'package:registro_prestamos/controllers/theme_controller.dart';
import 'package:registro_prestamos/data/repositories/authentication/authentication_repository.dart';
import 'package:registro_prestamos/feactures/personalization/screens/profile/profile.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticateProvider>().user!;
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///header
            PrimaryHeaderContainer(             
              child: Column(
                children: [
                  ///appbar
                  AppBarWidget(
                    title: Text(
                      'Account', 
                      style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white), 
                    ),
                  ),
                
                  ///user profile card
                 OUserProfileTilte(
                  name: '${user.name} ${user.lastname}',
                  email: user.email,
                  onPressed: () => Get.to(() => const ProfileScreen()),
                 ),                 
                 const SizedBox(height: Dimensions.spaceBtwSections,),

                ],
              ),
            ),
            ///body
             Padding(
              padding: const EdgeInsets.all(Dimensions.defaultSpace),
              child: Column(
                children: [
                  const SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(height: Dimensions.spaceBtwItems,),
                  
                   OSettingsMenuTitle(
                    icon: Iconsax.notification,
                    title: 'Notifications', 
                    subTile: 'Set any kind of notification message',
                    onTap: (){},
                  ),
                   OSettingsMenuTitle(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy', 
                    subTile: 'Manage data usage and connected accounts',
                    onTap: (){},
                  ),

                  /// app settings
                  const SizedBox(height: Dimensions.spaceBtwSections,),
                  const SectionHeading(title: 'App Settings', showActionButton: false,),
                  const SizedBox(height: Dimensions.spaceBtwItems,),
                  OSettingsMenuTitle(
                  icon: Iconsax.moon,
                  title: 'Dark Mode',
                  subTile: 'Enable or disable dark theme',
                  trailing: Obx(() => Switch(
                        value: themeController.isDarkMode.value,
                        onChanged: (value) {
                          themeController.toggleTheme(value);
                        },
                      )),
                ),

                  ///logout
                  const SizedBox(height: Dimensions.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){
                      AuthenticationRepository.instance.signOut();
                    }, child: const Text('Logout')),
                  ),
                  const SizedBox(height: Dimensions.spaceBtwSections*2.5),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

