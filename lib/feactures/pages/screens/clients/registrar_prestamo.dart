import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/button/elevated_button_widget.dart';
import 'package:registro_prestamos/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:registro_prestamos/provider/client_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';

class RegistrarPrestamo extends StatelessWidget {
  RegistrarPrestamo({super.key});
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
  Widget build(BuildContext context) {
    final clientProvider = context.read<ClientProvider>();

    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        color: MyColors.primary,
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
                    controller: totalLoan,
                    keyboardType: TextInputType.number,
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
                    text: 'Guardar',
                    onTap: () {
                      prestamoController.createPrestamo(
                        totalLoan: int.parse(totalLoan.text),
                        dueDate: dueDate.text,
                      );
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
