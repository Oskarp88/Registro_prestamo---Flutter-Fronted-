import 'package:flutter/material.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';

class LoginHaeder extends StatelessWidget {
  const LoginHaeder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuntions.isDarkMode(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image(
        //   height: 150,
        //   image: AssetImage(AssetsManager.clashcycle)
        // ),
        Image.asset(
          dark 
           ? AssetsManager.clashcycleDark 
           : AssetsManager.clashcycle,
          height: 100
        ),
        const SizedBox(height: 20),
        Text(
          'Inicia sesión',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: Dimensions.sm),
        Text('Bienvenido de nuevo', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}


