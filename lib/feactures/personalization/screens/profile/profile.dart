import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/images/circular_image.dart';
import 'package:registro_prestamos/common/widgets/texts/section_headig.dart';
import 'package:registro_prestamos/feactures/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(
        showBackArrow: true,
        title: Text('Profile'),
      ),

      ///body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.defaultSpace),
          child: Column(
            children: [
              const SizedBox(height: Dimensions.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Dimensions.spaceBtwItems),
              const SectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(height: Dimensions.spaceBtwItems),
              ProfileMenu(
                onPressed: (){},
                title: 'Name',
                value: 'Oscar William',
              ),
               ProfileMenu(
                onPressed: (){},
                title: 'Username',
                value: 'Oskarp88',
              ),
              const SizedBox(height: Dimensions.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Dimensions.spaceBtwItems),
              const SectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: Dimensions.spaceBtwItems),
              ProfileMenu(
                onPressed: (){},
                title: 'User ID',
                value: '12837474',
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                onPressed: (){},
                title: 'E-mail',
                value: 'burgos@gmail.com',
              ),
              ProfileMenu(
                onPressed: (){},
                title: 'Phone number',
                value: '319.........',
              ),
              ProfileMenu(
                onPressed: (){},
                title: 'Gender',
                value: 'Male',
              ),
              ProfileMenu(
                onPressed: (){},
                title: 'Date of Birth',
                value: '21 agosto 1990',
              ),
              const SizedBox(height: Dimensions.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: (){}, 
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

