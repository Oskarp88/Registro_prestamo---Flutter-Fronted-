import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';

class LoanHistoryClientScreen extends StatelessWidget {
  LoanHistoryClientScreen({super.key, required this.historyList, required this.client});

  final List<dynamic> historyList;
  final ClientModel client;
  String? lastDate;

  @override
  Widget build(BuildContext context) {
    
     lastDate = null;
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
                      'Historial de movimiento',
                      style: MyTextStyle.headlineMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cliente: ${client.name} ${client.lastname}'
                        ),
                        Text(
                       'Cedula: ${client.cedula}'
                    ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: Dimensions.spaceBtwSections),
                ],
              ),
            ),
          ),

          /// Historial
          Expanded(
            child:  ListView.builder(
                    padding: const EdgeInsets.all(Dimensions.defaultSpace),
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      final creationDate = DateTime.parse(history['date'].toString()).subtract(const Duration(hours: 5));
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
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    history[Constants.status] == Constants.deudafinalizada
                                      ? 'Deuda finalizada.'
                                      : history[Constants.status] == Constants.interesPagado
                                        ? 'Interés pagado'
                                        :  history[Constants.status] == Constants.deudaCompletaPagada
                                          ? 'Deuda finalizada'
                                          : history[Constants.status] == Constants.abono
                                            ? "Abono a la deuda"
                                            : '',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    history[Constants.status] == Constants.deudafinalizada
                                      ? 'Debia ${formatCurrency(history['total_loan'])}. Pagó ${formatCurrency(history['interestPayment'])} de interés y Abono${formatCurrency(history['paymentAmount'])}.'
                                      : history[Constants.status] == Constants.interesPagado
                                        ? 'Debe ${formatCurrency(history['total_loan'])} Pagó ${formatCurrency(history['interestPayment'])} de interés Abono${formatCurrency(history['paymentAmount'])}.'
                                        : history[Constants.status] == Constants.deudaCompletaPagada
                                          ? 'Pago durante los primeros 15 dias el prestamo de ${formatCurrency(history['total_loan'])} y el interés de ${formatCurrency(history['interestPayment'])} Un total de ${formatCurrency(history['paymentAmount']+history['interestPayment'])}\n'
                                          : history[Constants.status] == Constants.abono
                                            ? 'Abono ${formatCurrency(history['paymentAmount'])} a la deuda\n'
                                              'Su deuda se redujo a ${formatCurrency(history['total_loan'])}.'
                                            : '',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
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
                  )
          ),
        ],
      ),
    );
  }
}
