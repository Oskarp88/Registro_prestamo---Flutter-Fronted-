import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/authentication/controllers/auth_controller.dart';
import 'package:registro_prestamos/feactures/authentication/screens/password_configuration/forgot_password.dart';
import 'package:registro_prestamos/feactures/authentication/screens/signup/signup.dart';
import 'package:registro_prestamos/navigation_menu.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';

class LoginForm extends StatefulWidget {
   const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final authController = Get.find<AuthControllers>();
  final TextEditingController emailOrUsernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: emailOrUsernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: 'Email o Usuario',
              ),
            ),
            const SizedBox(height: Dimensions.spaceBtwInputFields,),
            TextFormField(
              controller: passwordController,
              obscureText: !isPasswordVisible.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible.value ? Iconsax.eye : Iconsax.eye_slash,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible.value = !isPasswordVisible.value;
                    });                    
                  },
                ),
              ),
            ),
            const SizedBox(height: Dimensions.spaceBtwInputFields/2),
            /// remenber me & forget password 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///remenber me
                 Row(
                  children: [
                    Checkbox(
                      value: true, 
                      onChanged: (value){}
                    ),
                    const Text('Remember me')
                  ],
                 ),
                 //forgot
                 TextButton(
                  onPressed: ()=> Get.to(() => const ForgotPassword()), 
                  child: const Text('Forgot password')
                 ),
              ],
            ),
            const SizedBox(height: Dimensions.spaceBtwSections,),
        
            ///Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async { 
                  print('*********************llamando a login***************************');
                  await authController.singIn(
                    emailOrUsernameController.text.toString().trim(), 
                    passwordController.text.toString().trim()
                  );               
                }, 
                child: const Text('Sing In')
              ),
            ),
            ///Create In Button
            const SizedBox(height: Dimensions.spaceBtwInputFields,),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignupScreen()), 
                child: const Text('Create Account')
              ),
            ),
          ],
        ),
      )
    );
  }
}