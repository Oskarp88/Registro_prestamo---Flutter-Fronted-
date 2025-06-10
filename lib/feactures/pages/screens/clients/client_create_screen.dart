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

class ClientCreateScreen extends StatelessWidget {
  ClientCreateScreen({super.key});
  final clientControllers = Get.find<ClientController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        color: MyColors.primary,
        title: Text('Crear Cliente'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: THelperFuntions.screenWidth() > 450 ? 450 : double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  Text('Crea tu cliente', style: MyTextStyle.titleLarge,),
                  SizedBox(height: Dimensions.spaceBtwSections,),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: 'Nombres',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields,),
                  TextFormField(
                    controller: lastnameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: 'Apellidos',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields,),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: 'Correo',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields,),
                  TextFormField(
                    controller: cedulaController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: 'Numero de Cedula',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields,),
                   TextFormField(
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: 'Numero de Telefono',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields,),
                  ElevatedButtonWidget(
                    text: 'Registrar Cliente', 
                    onTap: ()async{
                      await clientControllers.createClient(
                        name: nameController.text.toString(), 
                        lastname: lastnameController.text.toString(), 
                        cedula: int.parse(cedulaController.text), 
                        email: emailController.text.toString(), 
                        phoneNumber: phoneNumberController.text.toString()
                      );
                    }
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}