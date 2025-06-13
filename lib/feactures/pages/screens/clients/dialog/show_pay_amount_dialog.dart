import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';

void showPayAmountDialog(
  BuildContext context, 
   LoanModel loans,
   double payAmount,
) {

  final registrarPago = Get.find<RegistroDePrestamoController>();
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pagar ó Abonar a la deuda'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Vas a pagar un monto de ${formatCurrency(payAmount)}.\n'
                '¿Estas seguro de pagar este monto?'),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: formatCurrency(payAmount).toString()),
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto a pagar',
                prefixIcon: Icon(Iconsax.money),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No', style: TextStyle(fontSize: 18),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            ),     
            onPressed: () async{
              if (payAmount <= 0) {
                Loaders.errorSnackBar(
                  title: 'Error',
                  message: 'Debes ingresar una cantidad válida.',
                );
                return;
              }
              registrarPago.paymentAmount(
                id: loans.clientId, 
                paymentAmount: payAmount, 
              );
              Navigator.pop(context);
            },
            child: const Text('Sí, Pagar'),
          ),
        ],
      );
    },
  );
}
