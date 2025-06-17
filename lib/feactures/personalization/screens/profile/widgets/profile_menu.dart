import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.leading,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData? leading;
  final IconData icon;
  final VoidCallback onPressed;
  final String title;
  final Widget value; // ahora es Widget, no String

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.spaceBtwItems / 1.5),
        child: Row(
          children: [
            if (leading != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(leading, size: 18),
              ),
            Expanded(
              flex: 4,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 4,
              child: value, // el Widget value aquí
            ),
            Icon(icon, size: 18),
          ],
        ),
      ),
    );
  }
}
