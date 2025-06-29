import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/button/elevated_button_widget.dart';
import 'package:prestapp/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:prestapp/feactures/pages/screens/clients/dialog/show_register_loan.dart';
import 'package:prestapp/provider/client_provider.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/validators/validation.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 

class RegistrarPrestamo extends StatefulWidget {
  const RegistrarPrestamo({
    super.key, 
    this.isCreate = true, 
    this.clientId = ""
  });

  final bool isCreate;
  final String clientId;
  @override
  State<RegistrarPrestamo> createState() => _RegistrarPrestamoState();
}

class _RegistrarPrestamoState extends State<RegistrarPrestamo> {
  final prestamoController = Get.find<RegistroDePrestamoController>();

  TextEditingController totalLoan = TextEditingController();

  TextEditingController dueDate = TextEditingController();

  // 👇 función para mostrar el DatePicker
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.primary, // color del encabezado
              onPrimary: Colors.white,   // color del texto en encabezado
              onSurface: Colors.black,   // color del texto en calendario
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dueDate.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context){
    final clientProvider = context.watch<ClientProvider>();
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        color: MyColors.esmeralda5,
        title: Text('Registro de préstamo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: THelperFuntions.screenWidth() > 450 ? 450 : double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              child: Column(
                children: [
                  Text('Registro de préstamo del cliente:', style: MyTextStyle.titleLarge),
                  Text(clientProvider.clientModel!.name, style: MyTextStyle.headlineSmall),
                  SizedBox(height: Dimensions.spaceBtwSections),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: totalLoan,
                    validator: (value) => Validator.validateOnlyNumbers(value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.money),
                      labelText: 'Cantidad total del préstamo',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields),
                  TextFormField(
                    controller: dueDate,
                    readOnly: true, // no pueda escribir directamente
                    onTap: () => _selectDueDate(context),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.calendar),
                      labelText: 'Fecha límite (mensual)',
                    ),
                  ),
                  SizedBox(height: Dimensions.spaceBtwInputFields),
                  ElevatedButtonWidget(
                    text: 'Crear prestamo',
                    onTap: () {
                      if(totalLoan.text.isEmpty){
                        Loaders.errorSnackBar(
                          title: 'Campo vacío',
                          message: 'Por favor ingresa una cantidad del prestamo.',
                        );
                        return;
                      }
                      double? amount = double.tryParse(totalLoan.text);
                      if (amount == null || amount <= 0) {
                        Loaders.errorSnackBar(
                          title: 'Cantidad inválida',
                          message: 'Por favor ingresa una cantidad válida mayor a 0.',
                        );
                        return;
                      }
                      if(dueDate.text.isEmpty){
                        Loaders.errorSnackBar(
                          title: 'Campo vacio',
                          message: 'Por favor ingresa la fecha de pago.',
                        );
                        return;
                      }
                      showRegisterLoan(
                        context, 
                        widget.isCreate, 
                        clientProvider.clientModel!.id, 
                        clientProvider.clientModel!.name,
                        dueDate.text.toString(),
                        int.parse(totalLoan.text),
                      );
                      // widget.isCreate 
                      //   ? prestamoController.createPrestamo(
                      //       id: clientProvider.clientModel!.id,
                      //       totalLoan: int.parse(totalLoan.text),
                      //       dueDate: dueDate.text.toString(),
                      //     ) 
                      //   : prestamoController.updatePrestamo(
                      //     id: widget.clientId,
                      //     totalLoan: int.parse(totalLoan.text),
                      //     dueDate: dueDate.text.toString(),
                      //   );
                    },
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
