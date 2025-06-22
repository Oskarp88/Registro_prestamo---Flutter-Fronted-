import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/data/services/api_service.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/loan_history_client_screen.dart';
import 'package:prestapp/model/client.dart';
import 'package:prestapp/model/loan.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/helpers/methods.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/manager/assets_manager.dart';
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
  if (phone.isEmpty) {
    Loaders.warningSnackBar(title: 'Número de teléfono no disponible.');
    return;
  }

  final dia = widget.loanModel.dueDate!.split('-')[2];
  final mes = widget.loanModel.dueDate!.split('-')[1].toString();
  final anio = widget.loanModel.dueDate!.split('-')[0];

  final message = Uri.encodeFull(
      "Hola ${clientModel?.name}, recuerda que tienes un interés de 15% pendiente de \$${formatCurrency(widget.loanModel.interest)}. "
      "Tu fecha limite para pagar el interes es el $dia de ${meses[int.parse(mes)]} de $anio.\n"
      "\n"
      "Recuerda que si te pasas de la fecha el interés aumenta a 18%.");

  final whatsappUrl = Uri.parse("whatsapp://send?phone=57$phone&text=$message");
  final url = Uri.parse("https://wa.me/57$phone?text=$message");

  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    if (kDebugMode) print('WhatsApp intent directo abierto.');
  } else if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
    if (kDebugMode) print('URL wa.me abierta en navegador o app compatible.');
  } else {
    if (kDebugMode) {
      print('No se pudo abrir WhatsApp ni wa.me URL');
    }
    Loaders.warningSnackBar(
        title: 'No se pudo abrir WhatsApp. Verifica que esté instalado.');
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
                  : SizedBox(
                    width: THelperFuntions.screenWidth() > 700 ? 700 : double.infinity,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Información del Cliente',
                              style: MyTextStyle.titleLarge),
                          const SizedBox(height: 12),
                          _buildInfoRow(Iconsax.user, 'Nombre',
                              '${clientModel!.name} ${clientModel!.lastname}'),
                          _buildInfoRow(Iconsax.card, 'Cédula',
                              clientModel!.cedula.toString()),
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
                              icon: Image.asset(AssetsManager.iconWhatsApp, width: 30,),
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
                                  side: BorderSide.none
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: (){
                                Get.to(() => LoanHistoryClientScreen(
                                  historyList: widget.loanModel.history,
                                  client: clientModel!,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide.none
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.history, color: Colors.blueAccent, size: 30,),
                                  SizedBox(width: 10),
                                  const Text(
                                    'Historial de pagos',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
  
                        ],
                      ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
