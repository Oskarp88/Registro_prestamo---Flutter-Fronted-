import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/data/services/api_service.dart'; // Asegúrate de importar aquí
import 'package:registro_prestamos/model/history_capital.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';

class GananciasHistoryScreen extends StatefulWidget {
  const GananciasHistoryScreen({super.key});

  @override
  State<GananciasHistoryScreen> createState() => _GananciasHistoryScreenState();
}

class _GananciasHistoryScreenState extends State<GananciasHistoryScreen> {
  late Future<List<CapitalHistoryModel>> _capitalHistory;

  @override
  void initState() {
    super.initState();
    _capitalHistory = ApiService().fetchCapitalHistory(value: 'history-ganancias');
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
                      'Historial de movimiento\nde tus ganancias',
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
                      final now = DateTime.now();
                      final isToday = creationDate.year == now.year &&
                                      creationDate.month == now.month &&
                                      creationDate.day == now.day;
                      final dateFormatted = isToday
                        ? 'Hoy'
                        : DateFormat('d \'de\' MMMM', 'es_ES').format(creationDate);
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
                                history.state == Constants.retiro
                                  ? 'Retiraste \$${formatCurrency(history.amount)} de tus ganancias.'
                                  : history.state == Constants.transferenciaAGanancias 
                                    ? 'Recibiste una transferencia de \$${formatCurrency(history.amount)} desde tu capital a tus ganancias.'
                                    : history.state == Constants.transferenciaACapital  
                                      ? 'Transferiste \$${formatCurrency(history.amount)} desde tus ganancias a tu capital.'
                                      : 'El cliente ${history.clientName} pagó \$${formatCurrency(history.amount)} en concepto de intereses.',
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
