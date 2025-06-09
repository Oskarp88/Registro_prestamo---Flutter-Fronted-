import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/common/widgets/list_title/settings_menu_title.dart';
import 'package:registro_prestamos/common/widgets/list_title/user_profile_title.dart';
import 'package:registro_prestamos/common/widgets/texts/section_headig.dart';
import 'package:registro_prestamos/feactures/personalization/screens/profile/profile.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                 OUserProfileTilte(onPressed: () => Get.to(() => const ProfileScreen()),),                 
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
                    icon: Iconsax.safe_home,
                    title: 'My Address', 
                    subTile: 'Set Shopping delivery address',
                    onTap: (){},
                  ),
                   OSettingsMenuTitle(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart', 
                    subTile: 'Add, remove products and move to checkout',
                    onTap: (){},
                  ),
                   OSettingsMenuTitle(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders', 
                    subTile: 'In progress and Completed Orders',
                    onTap: (){},
                  ),
                   OSettingsMenuTitle(
                    icon: Iconsax.bank,
                    title: 'Bank Account', 
                    subTile: 'Withdraw balance to registered bank account',
                    onTap: (){},
                  ),
                   OSettingsMenuTitle(
                    icon: Iconsax.discount_shape,
                    title: 'My Couppons', 
                    subTile: 'List of all the discounted coupons',
                    onTap: (){},
                  ),
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
                  const OSettingsMenuTitle(
                    icon: Iconsax.document_upload1,
                    title: 'Load Data', 
                    subTile: 'Upload Data to your Cloud Firebase'
                  ),
                  OSettingsMenuTitle(
                    icon: Iconsax.location,
                    title: 'Geolocation', 
                    subTile: 'Set recommendation based on location',
                    trailing: Switch(value: true, onChanged: (value){}),
                  ),
                  OSettingsMenuTitle(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode', 
                    subTile: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value){}),
                  ),
                  OSettingsMenuTitle(
                    icon: Iconsax.image,
                    title: 'HD Image Quality', 
                    subTile: 'Set Image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value){}),
                  ),

                  ///logout
                  const SizedBox(height: Dimensions.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){}, child: const Text('Logout')),
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

