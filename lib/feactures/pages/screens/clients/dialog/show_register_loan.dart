import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/feactures/pages/controllers/registro_de_prestamo_controller.dart';
import 'package:prestapp/utils/helpers/methods.dart';

void showRegisterLoan(
  BuildContext context, 
  bool isCreate,
  String clientId,
  String name,
  String dueDate,
  int totalLoan
) {
  final prestamoController = Get.find<RegistroDePrestamoController>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Registrar préstamo'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Monto total del préstamo'),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: formatCurrency(totalLoan.toDouble())),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Monto total',
                prefixIcon: Icon(Iconsax.money),
              ),
            ),
            const SizedBox(height: 10),
            const Text('Fecha límite para pagar el interés'),
            const SizedBox(height: 5),
            TextField(
              controller: TextEditingController(text: dueDate),
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Fecha de pago',
                prefixIcon: Icon(Iconsax.calendar),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '¿Está seguro de que ${formatCurrency(totalLoan.toDouble())} es la cantidad correcta a prestar?',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
          ],
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(fontSize: 18)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            ),
            onPressed: () {
              isCreate 
                ? prestamoController.createPrestamo(
                    id: clientId,
                    totalLoan: totalLoan,
                    dueDate: dueDate,
                    name: name
                  )
                : prestamoController.updatePrestamo(
                    id: clientId,
                    totalLoan: totalLoan,
                    dueDate: dueDate,
                    name: name
                  );
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}
