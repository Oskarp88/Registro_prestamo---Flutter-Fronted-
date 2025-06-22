import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/feactures/authentication/controllers/auth_controller.dart';
import 'package:prestapp/feactures/authentication/screens/password_configuration/verify_code_screen.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isWide = THelperFuntions.screenWidth() > 600;

    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        title: const Text('Recuperar contraseña'),
      ),
      body: Center(
        child: SizedBox(
          width: isWide ? 600 : double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Título
                  Text(
                    '¿Olvidaste tu contraseña?',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),

                  /// Descripción
                  Text(
                    'Ingresa tu correo electrónico o nombre de usuario y te enviaremos un código de verificación para restablecer tu contraseña.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),

                  /// Campo de entrada
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Correo o nombre de usuario',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Este campo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  /// Botón
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                           AuthControllers().forgotPassword(
                            usernameOrEmail: _emailController.text.trim(),
                            onSuccess: (emailOrUsername){
                              Get.to(()=>VerifyCodeScreen(emailOrUsername: emailOrUsername));
                            }             
                          );
                        }
                      },
                      child: const Text('Enviar código'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
