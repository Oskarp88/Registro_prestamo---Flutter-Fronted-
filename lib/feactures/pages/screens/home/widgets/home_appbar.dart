import 'package:flutter/material.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarWidget( title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good day for shopping',
          style: Theme.of(context).textTheme.labelMedium!.apply(color: MyColors.grey),
        ),
         Text(
          'Oscar William',
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: MyColors.white),
        ),
      ],
     ),
    );
  }
}

