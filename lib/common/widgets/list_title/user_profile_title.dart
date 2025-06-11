import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/widgets/images/circular_image.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class OUserProfileTilte extends StatelessWidget {
  const OUserProfileTilte({
    super.key, required this.onPressed, required this.name, required this.email,
  });
  final String name;
  final String email;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
     title: Text(
       name,
       style: Theme.of(context).textTheme.headlineSmall!.apply(color: MyColors.white),
     ),
     subtitle: Text(
       email,
       style: Theme.of(context).textTheme.bodyMedium!.apply(color: MyColors.white)
     ),
     trailing: IconButton(
       onPressed: onPressed, 
       icon: const Icon(Iconsax.edit, color: MyColors.white,)
     ),
    );
  }
}