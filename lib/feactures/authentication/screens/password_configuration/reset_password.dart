
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/feactures/authentication/controllers/auth_controller.dart';
import 'package:prestapp/feactures/authentication/screens/login/login.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';

class ResetPassword extends StatefulWidget {
  final String userId;
  const ResetPassword({super.key, required this.userId});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final isWide = THelperFuntions.screenWidth() > 600;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: isWide ? 500 : double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                   
                    const SizedBox(height: Dimensions.spaceBtwItems),

                    /// Título
                    Text(
                      'Restablecer contraseña',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.spaceBtwItems),

                    /// Descripción
                    Text(
                      'Ingresa tu nueva contraseña. Asegúrate de que sea segura y fácil de recordar.',
                      style: Theme.of(context).textTheme.labelMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimensions.spaceBtwSections),

                    /// Campo de nueva contraseña
                    TextFormField(
                      controller: _password,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Nueva contraseña',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'La contraseña debe tener al menos 6 caracteres';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// Confirmar contraseña
                    TextFormField(
                      controller: _confirmPassword,
                      obscureText: _obscure,
                      decoration: const InputDecoration(
                        labelText: 'Confirmar contraseña',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (value) {
                        if (value != _password.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Dimensions.spaceBtwSections),

                    /// Botón de enviar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthControllers().resetPassword(
                              userId: widget.userId,
                              newPassword: _password.text.trim(),
                              onSuccess: () => Get.offAll(()=> LoginScreen())
                            );
                          }
                        },
                        child: const Text('Restablecer contraseña'),
                      ),
                    ),
                    const SizedBox(height: Dimensions.spaceBtwItems),

                    /// Botón reenviar (opcional, solo decorativo aquí)
                    TextButton(
                      onPressed: () {
                        Loaders.warningSnackBar(
                          title: 'Código vencido',
                          message: 'Solicita un nuevo código desde la pantalla anterior.',
                        );
                      },
                      child: const Text('Solicitar un nuevo código'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
