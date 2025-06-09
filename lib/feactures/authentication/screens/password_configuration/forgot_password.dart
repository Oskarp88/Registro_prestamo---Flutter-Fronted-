import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/authentication/screens/password_configuration/reset_password.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///headings
            Text(
              'Forgot Password',
               style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            Text(
              'ooooooooooo',
              style: Theme.of(context).textTheme.labelMedium
            ),
            const SizedBox(height: 40),
            ///text field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon:  Icon(Iconsax.direct_right) 
              ),
            ),
            const SizedBox(height: 20),
            ///Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()=> Get.off(()=> const ResetPassword()),
                child: const Text('Submit')
              ),
            ),
          ],
        ),
      ),
    );
  }
}