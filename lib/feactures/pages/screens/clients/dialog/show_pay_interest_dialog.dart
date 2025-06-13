import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';

void showPayInterestDialog(
  BuildContext context, 
   LoanModel loans,
) {
  final TextEditingController interestController =
      TextEditingController(text: loans.interest.toInt().toString());
  final registrarPago = Get.find<RegistroDePrestamoController>();
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pagar Interés'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Vas a pagar un interés de ${formatCurrency(loans.interest)}.\n'
                'Si deseas, puedes modificar la cantidad a pagar:'),
            const SizedBox(height: 12),
            TextFormField(
              controller: interestController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto a pagar',
                prefixIcon: Icon(Iconsax.money),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async{
              double enteredAmount = double.tryParse(interestController.text) ?? 0;

              if (enteredAmount <= 0) {
                Loaders.errorSnackBar(
                  title: 'Error',
                  message: 'Debes ingresar una cantidad válida.',
                );
                return;
              }

              if (enteredAmount.toInt() < loans.interest.toInt()) {
                // Confirmación adicional
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Confirmar pago parcial'),
                      content: Text(
                          'Estás a punto de pagar ${formatCurrency(enteredAmount)}.\n'
                          'El restante (${formatCurrency((loans.interest.toInt() - enteredAmount.toInt()).toDouble())}) se sumará al interés del próximo mes.\n'
                          'En total tu proximo interes seria de: ${formatCurrency(((loans.interest.toInt() - enteredAmount.toInt()) + loans.interest.toInt()).toDouble())}. \n'
                          'Ademas si no pagas el interes completo no podras abonar a tu deuda. \n'
                          '¿Deseas continuar?'),
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
                            Navigator.pop(context); 
                            Navigator.pop(context); 

                            Loaders.successSnackBar(
                              title: 'Pago realizado',
                              message: 'Has pagado ${formatCurrency(enteredAmount)} de interés.',
                            );
                          },
                          child: const Text('Confirmar'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                // Pago completo
                Navigator.pop(context);
                // Aquí lógica para pago completo
                // processInterestPayment(enteredAmount);
                await registrarPago.payInterest(id: loans.clientId, interest: enteredAmount);
                Loaders.successSnackBar(
                  title: 'Pago realizado',
                  message: 'Has pagado ${formatCurrency(enteredAmount)} de interés.',
                );
              }
            },
            child: const Text('Pagar'),
          ),
        ],
      );
    },
  );
}
