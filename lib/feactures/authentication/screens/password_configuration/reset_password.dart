
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: ()=> Get.back(), 
            icon: const Icon(CupertinoIcons.clear)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Image(
                image: const AssetImage(AssetsManager.sendEmailImage),
                width: THelperFuntions.screenWidth()*0.6,
              ),
              const SizedBox(height: 20,),
              Text(
                 'Password Reset Email Sent', 
                 style: Theme.of(context).textTheme.headlineMedium,
                 textAlign: TextAlign.center,
              ),
              const SizedBox(height: Dimensions.spaceBtwItems,),
                Text(
                  'uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu',
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Dimensions.spaceBtwSections,),

                ///button
                SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){}, 
                  child: const Text('Done')
                ),
               ),
                const SizedBox(height: Dimensions.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: ()=> Get.off(()=> const ResetPassword()),
                  child: const Text('Resend Email')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}