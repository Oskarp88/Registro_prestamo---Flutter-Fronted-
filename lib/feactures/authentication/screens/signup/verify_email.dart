import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/feactures/authentication/screens/login/login.dart';
import 'package:prestapp/utils/constants/dimensions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen
({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()), 
            icon: const Icon(CupertinoIcons.clear)
          )
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.defaultSpace),
          child: Column(
            children: [
               //image
              //  Image(
              //   image: const AssetImage(AssetsManager.verifyEmailImage),
              //   width: THelperFuntions.screenWidth()*0.6,
              //  ),
               const SizedBox(height: Dimensions.spaceBtwSections),
               //title & subtitle
               Text(
                'Verify your email address!', 
                 style: Theme.of(context).textTheme.headlineMedium,
                 textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.spaceBtwItems),
                Text(
                'oscar@gmail.com', 
                 style: Theme.of(context).textTheme.labelLarge,
                 textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.spaceBtwItems),
                Text(
                'Congratulations your account awaits verify your email', 
                 style: Theme.of(context).textTheme.labelMedium,
                 textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.spaceBtwSections),

               ///button
               SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  
                  child: const Text('Continue'),
                ),
               ),
              const SizedBox(height: Dimensions.spaceBtwItems),
               SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: (){}, 
                  child: const Text('Resend Email')
                ),
               ),
            ],
          )
        ),
      ),
    );
  }
}