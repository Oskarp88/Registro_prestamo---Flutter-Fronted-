import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/data/services/api_service.dart';
import 'package:prestapp/model/history_capital.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/methods.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  late Future<List<CapitalHistoryModel>> _capitalHistory;

  @override
  void initState() {
    super.initState();
    _capitalHistory = ApiService().fetchCapitalHistory();
  }

  String? lastDate; // Para almacenar la última fecha mostrada

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarWidget(
                    showBackArrow: true,
                    title: Text(
                      'Historial de movimiento\ndel capital',
                      style: MyTextStyle.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: Dimensions.spaceBtwSections),
                ],
              ),
            ),
          ),

          /// Historial
          Expanded(
            child: FutureBuilder<List<CapitalHistoryModel>>(
              future: _capitalHistory,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay movimientos registrados.'));
                } else {
                  final historyList = snapshot.data!;
                  lastDate = null;

                  return ListView.builder(
                    padding: const EdgeInsets.all(Dimensions.defaultSpace),
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      final creationDate = DateTime.parse(history.creationDate.toString()).subtract(const Duration(hours: 5));
                      final dateFormatted = DateFormat('d \'de\' MMMM', 'es_ES').format(creationDate);
                      final timeFormatted = DateFormat('HH:mm:ss').format(creationDate);

                      // Si la fecha cambia, la mostramos
                      final showDate = lastDate != dateFormatted;
                      if (showDate) lastDate = dateFormatted;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showDate)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                dateFormatted,
                                style: MyTextStyle.titleMedium.copyWith(color: Colors.grey[700]),
                              ),
                            ),

                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(Iconsax.activity, color: Colors.blueAccent),
                              title: Text(
                                history.state == Constants.deposito 
                                  ? 'Realizaste un depósito de \$${formatCurrency(history.amount)} a tu capital.'
                                  : history.state == Constants.transferenciaAGanancias
                                    ? 'Transferiste \$${formatCurrency(history.amount)} a tu cuenta de ganancias.'
                                    : history.state == Constants.transferenciaACapital
                                      ? 'Recibiste una transferencia de \$${formatCurrency(history.amount)} desde tu cuenta de ganancias a tu capital.'
                                      : history.state == Constants.retiro
                                        ? 'Realizaste un retiro de \$${formatCurrency(history.amount)} desde tu cuenta de ganancias.'
                                        : history.state == Constants.prestamo
                                          ? 'Prestaste \$${formatCurrency(history.amount)} al cliente ${history.clientName}.'
                                          : history.state == Constants.pagoTodo 
                                            ? 'El cliente ${history.clientName} liquidó la totalidad de su préstamo en los primeros 15 días con un pago de \$${formatCurrency(history.amount)}.'
                                            : history.state == Constants.deudafinalizada  
                                              ? 'El cliente ${history.clientName} abonó \$${formatCurrency(history.amount)} y completó el pago total de su deuda.'
                                              : 'El cliente ${history.clientName} realizó un abono de \$${formatCurrency(history.amount)} a su deuda.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              subtitle: Text(
                                timeFormatted.substring(0,5),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
