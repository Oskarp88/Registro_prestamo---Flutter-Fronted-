import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/authentication/screens/signup/verify_email.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/validators/validation.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFuntions.isDarkMode(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Nombres y Apellidos
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameController,
                  validator: (value) => Validator.validateText(value!, 'Nombre'),
                  decoration: const InputDecoration(
                    labelText: 'Nombres',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: Dimensions.inputFieldFieds),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  validator: (value) => Validator.validateText(value!, 'Apellidos'),
                  decoration: const InputDecoration(
                    labelText: 'Apellidos',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.inputFieldFieds),

          // Nombre de usuario
          TextFormField(
            controller: usernameController,
            validator: (value) => Validator.validateText(value!, 'Nombre de usuario'),
            decoration: const InputDecoration(
              labelText: 'Nombre de usuario',
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: Dimensions.inputFieldFieds),

          // Email
          TextFormField(
            controller: emailController,
            validator: (value) => Validator.validateEmail(value!),
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: Dimensions.inputFieldFieds),

          // Contraseña
          TextFormField(
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Contraseña requerida';
              } else if (value.length < 6) {
                return 'Debe tener al menos 6 caracteres';
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Debe contener al menos un número';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: Dimensions.inputFieldFieds),

          // Confirmar Contraseña
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirme la contraseña';
              } else if (value != passwordController.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Confirmar contraseña',
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: Dimensions.inputFieldFieds),

          // Checkbox de términos
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      agreeToTerms = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: Dimensions.spaceBtwItems),
              Expanded(
                child: Text.rich(TextSpan(
                    children: [
                      TextSpan(text: 'Acepto la ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                        text: 'política de privacidad ',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? MyColors.white : MyColors.primaryColor,
                        ),
                      ),
                      TextSpan(text: 'y los ', style: Theme.of(context).textTheme.bodySmall),
                      TextSpan(
                        text: 'términos de uso',
                        style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: dark ? MyColors.white : MyColors.primaryColor,
                        ),
                      ),
                    ]
                )),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.spaceBtwSections),

          // Botón de crear cuenta
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() && agreeToTerms) {
                  final userData = {
                    Constants.name: nameController.text.trim(),
                    Constants.lastname: lastNameController.text.trim(),
                    Constants.username: usernameController.text.trim(),
                    Constants.email: emailController.text.trim(),
                    Constants.password: passwordController.text.trim(),
                  };
                  print("registrando*********************$userData");
                  await  AuthenticateProvider.instance.userRegister(userData);
                } else if (!agreeToTerms) {
                  Get.snackbar('Términos', 'Debes aceptar los términos y condiciones');
                }
              },
              child: const Text('Crear cuenta'),
            ),
          ),
        ],
      ),
    );
  }
}
