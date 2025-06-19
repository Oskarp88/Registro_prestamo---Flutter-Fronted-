import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/texts/section_headig.dart';
import 'package:registro_prestamos/feactures/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<AuthenticateProvider>().user!;
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
                title: 'Nombres',
                value: Text(userModel.name),
              ),
              ProfileMenu(
                onPressed: (){},
                title: 'Apellidos',
                value: Text(userModel.lastname),
              ),
               ProfileMenu(
                onPressed: (){},
                title: 'Nombre de usuario',
                value: Text(userModel.username),
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
                value: Text(userModel.id),
                icon: Iconsax.copy,
              ),
              ProfileMenu(
                onPressed: (){},
                title: 'E-mail',
                value: Text(userModel.email),
              ),
              
              ProfileMenu(
                onPressed: (){},
                title: 'Rol',
                value: Text(
                  userModel.isAdmin 
                    ? 'Administrador'
                    : 'Usuario'
                ),
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

