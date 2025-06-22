import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/utils/constants/my_colors.dart';

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