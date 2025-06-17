import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
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
       style: MyTextStyle.headlineSmall,
     ),
     subtitle: Text(
       email,
       style: MyTextStyle.bodyMedium
     ),
     trailing: IconButton(
       onPressed: onPressed, 
       icon: const Icon(Iconsax.edit, color: MyColors.white,)
     ),
    );
  }
}