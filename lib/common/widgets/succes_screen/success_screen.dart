import 'package:flutter/material.dart';
import 'package:prestapp/common/styles/spacing_styles.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';

class SuccessScreen extends StatelessWidget {
  final String image, title, sutTitle;
  final VoidCallback onPressed;
  const SuccessScreen({super.key,
    required this.image,
    required this.sutTitle,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              Image(
                image: AssetImage(image),
                width: THelperFuntions.screenWidth()*0.6,
              ),
              const SizedBox(height: Dimensions.spaceBtwSections,),
              Text(
                 title, 
                 style: Theme.of(context).textTheme.headlineMedium,
                 textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.spaceBtwItems,),
                Text(
                  sutTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.spaceBtwSections,),

                ///button
                SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed, 
                  child: const Text('Continue')
                ),
               ),

            ],
          ),
        ),
      ),
    );
  }
}