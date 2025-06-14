import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/pages/controllers/capital_controller.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';

void showUpdateCapitalDialog(
  BuildContext context, 
) {
  final TextEditingController capitalController = TextEditingController();
  final registrarCapital = Get.find<CapitalController>();
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Agregar al capital'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ingresa la cantidad que agregarás al capital'
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: capitalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad a ingresar',
                  prefixIcon: Icon(Iconsax.money),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10)
            ),
            onPressed: () async{
              double enteredAmount = double.tryParse(capitalController.text) ?? 0;

              if (enteredAmount <= 0) {
                Loaders.errorSnackBar(
                  title: 'Error',
                  message: 'Debes ingresar una cantidad válida.',
                );
                return;
              }
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirmar Ingreso'),
                      content: Text(
                        'Estás a punto de ingresar ${formatCurrency(enteredAmount)}\n'
                        'a tu capital. \n'
                        '¿Deseas continuar?'
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2
                            )
                          ),
                          onPressed: () {
                            registrarCapital.updateCapital(capital: enteredAmount);
                            Navigator.pop(context); 
                            Navigator.pop(context); 
                             
                            Loaders.successSnackBar(
                              title: 'Capital ingresado',
                              message: 'Has ingresado ${formatCurrency(enteredAmount)} a tu capital.',
                              time: 3
                            );
                          },
                          child: const Text('Confirmar'),
                        ),
                      ],
                    );
                  },
                );
              },
            child: const Text('Ingresar'),
          ),
        ],
      );
    },
  );
}
