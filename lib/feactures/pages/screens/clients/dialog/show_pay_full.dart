import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:prestapp/model/loan.dart';
import 'package:prestapp/utils/helpers/methods.dart';

void showPayFullDialog(
  BuildContext context, 
   LoanModel loans,
) {

  final registrarPago = Get.find<RegistroDePrestamoController>();
  
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Pagar toda la deuda'),
        content: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Deuda a pagar'),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: formatCurrency(loans.totalLoan).toString()),
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Deuda',
                prefixIcon: Icon(Iconsax.money),
              ),
            ),
            const SizedBox(height: 10),
            Text('Interés a pagar'),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: formatCurrency(loans.totalLoan * 0.1).toString()),
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Interes',
                prefixIcon: Icon(Iconsax.money),
              ),
            ),
            const SizedBox(height: 10),
            Text('Total a pagar para saldar toda la deuda'),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: formatCurrency(loans.totalLoan + loans.totalLoan * 0.1).toString()),
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total a pagar',
                prefixIcon: Icon(Iconsax.money),
              ),
            ),
            const SizedBox(height: 20),
            Text('Esta seguro de pagar la cantidad de ${formatCurrency(loans.totalLoan + loans.totalLoan * 0.1).toString()}.'),
            const SizedBox(height: 2),
          ],
        ),
         
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15)
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('No', style: TextStyle(fontSize: 18),),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            ),     
           onPressed:() {
              registrarPago.paymentFull(
                id: loans.clientId,  
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
