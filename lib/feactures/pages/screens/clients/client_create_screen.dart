import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/button/elevated_button_widget.dart';
import 'package:registro_prestamos/feactures/pages/controllers/client_controller.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/validators/validation.dart';

class ClientCreateScreen extends StatelessWidget {
  ClientCreateScreen({super.key});

  final clientControllers = Get.find<ClientController>();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final cedulaController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        color: MyColors.primary,
        title: const Text('Crear Cliente'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: THelperFuntions.screenWidth() > 450 ? 450 : double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text('Crea tu cliente', style: MyTextStyle.titleLarge),
                    SizedBox(height: Dimensions.spaceBtwSections),
                    TextFormField(
                      controller: nameController,
                      validator: (value) => Validator.validateText(value!, 'Nombre'),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: 'Nombres',
                      ),
                    ),
                    SizedBox(height: Dimensions.spaceBtwInputFields),
                    TextFormField(
                      controller: lastnameController,
                      validator: (value) => Validator.validateText(value!, 'Apellido'),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: 'Apellidos',
                      ),
                    ),
                    SizedBox(height: Dimensions.spaceBtwInputFields),
                    TextFormField(
                      controller: emailController,
                      validator: (value) => Validator.validateEmail(value!),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: 'Correo',
                      ),
                    ),
                    SizedBox(height: Dimensions.spaceBtwInputFields),
                    TextFormField(
                      controller: cedulaController,
                      validator: (value) => Validator.validateCedula(value!),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: 'Número de Cédula',
                      ),
                    ),
                    SizedBox(height: Dimensions.spaceBtwInputFields),
                    TextFormField(
                      controller: phoneNumberController,
                      validator: (value) => Validator.validatePhoneNumber(value!),
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: 'Número de Teléfono',
                      ),
                    ),
                    SizedBox(height: Dimensions.spaceBtwInputFields),
                    ElevatedButtonWidget(
                      text: 'Registrar Cliente',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await clientControllers.createClient(
                            name: nameController.text.trim(),
                            lastname: lastnameController.text.trim(),
                            cedula: int.parse(cedulaController.text.trim()),
                            email: emailController.text.trim(),
                            phoneNumber: phoneNumberController.text.trim(),
                          );
                        }
                      },
                    )
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
