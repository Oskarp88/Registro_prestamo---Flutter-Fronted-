import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsAccountsClient extends StatefulWidget {
  const DetailsAccountsClient({super.key, required this.loanModel});
  final LoanModel loanModel;

  @override
  State<DetailsAccountsClient> createState() => _DetailsAccountsClientState();
}

class _DetailsAccountsClientState extends State<DetailsAccountsClient> {
  bool _isLoading = true;
  ClientModel? clientModel;

  @override
  void initState() {
    super.initState();
    _loadClient();
  }

  Future<void> _loadClient() async {
    try {
      final result = await ApiService().fetchClientById(widget.loanModel.clientId);
      setState(() {
        clientModel = result;
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando cliente: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _launchWhatsApp() async {
    final phone = clientModel?.phoneNumber ?? '';
    final message = Uri.encodeFull(
        "Hola ${clientModel?.name}, recuerda que tienes un interés pendiente de \$${widget.loanModel.interest.toStringAsFixed(2)}. "
        "Fecha límite de pago: ${widget.loanModel.dueDate ?? 'sin definir'}.");
    final url = Uri.parse("https://wa.me/$phone?text=$message");

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (kDebugMode) {
        print('No se pudo abrir WhatsApp');
      }
    }
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$title: ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

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
                      'Detalles Cliente',
                      style: MyTextStyle.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: Dimensions.spaceBtwSections),
                ],
              ),
            ),
          ),

          /// Contenido
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimensions.defaultSpace),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Información del Cliente',
                            style: MyTextStyle.titleLarge),
                        const SizedBox(height: 12),
                        _buildInfoRow(Iconsax.user, 'Nombre',
                            '${clientModel!.name} ${clientModel!.lastname}'),
                        _buildInfoRow(Iconsax.card, 'Cédula',
                            clientModel!.cedula.toString()),
                        _buildInfoRow(Iconsax.sms, 'Correo',
                            clientModel!.email),
                        _buildInfoRow(Iconsax.call, 'Teléfono',
                            clientModel!.phoneNumber),

                        const Divider(height: 30),

                        Text('Información del Préstamo',
                            style: MyTextStyle.titleLarge),
                        const SizedBox(height: 12),
                        _buildInfoRow(Iconsax.dollar_circle, 'Monto total',
                            '\$${formatCurrency(widget.loanModel.totalLoan)}'),
                        _buildInfoRow(Iconsax.money_2, 'Interés',
                            '\$${formatCurrency(widget.loanModel.interest)}'),
                        _buildInfoRow(Iconsax.money_recive, 'Pago mensual',
                            '\$${formatCurrency(widget.loanModel.paymentAmount)}'),
                        _buildInfoRow(Iconsax.status_up, 'Estado',
                            widget.loanModel.status),
                        _buildInfoRow(Iconsax.calendar, 'Fecha límite',
                            widget.loanModel.dueDate ?? 'Sin definir'),

                        const SizedBox(height: 30),

                        /// Botón WhatsApp
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _launchWhatsApp,
                            icon: const Icon(Iconsax.activity),
                            label: const Text(
                              'Enviar recordatorio por WhatsApp',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
