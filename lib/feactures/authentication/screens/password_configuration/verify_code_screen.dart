import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/feactures/authentication/controllers/auth_controller.dart';
import 'package:prestapp/feactures/authentication/screens/password_configuration/reset_password.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String emailOrUsername;

  const VerifyCodeScreen({super.key, required this.emailOrUsername});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isWide = THelperFuntions.screenWidth() > 600;

    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        title: const Text('Verificar código')
      ),
      body: Center(
        child: SizedBox(
          width: isWide ? 500 : double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Título
                  Text(
                    'Código de verificación',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),

                  /// Instrucción
                  Text(
                    'Introduce el código de 6 dígitos que hemos enviado a tu correo electrónico. Este código expira en 10 minutos.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 30),

                  /// Campo de código
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: const InputDecoration(
                      labelText: 'Código de verificación',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor ingresa el código';
                      }
                      if (value.trim().length != 6) {
                        return 'El código debe tener 6 dígitos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  /// Botón de continuar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthControllers().verifyResetCode(
                            emailOrUsername: widget.emailOrUsername,
                            code: _codeController.text.trim(),
                            onSuccess: (userId) {
                              print('llegue a onssucess');
                              Get.to(() => ResetPassword(userId: userId));
                            },
                          );
                        }
                      },
                      child: const Text('Verificar código'),
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
