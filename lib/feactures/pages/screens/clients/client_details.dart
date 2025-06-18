import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/button/elevated_button_widget.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/loan_history_client_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/dialog/show_pay_amount_dialog.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/dialog/show_pay_full.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/dialog/show_pay_interest_dialog.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/registrar_prestamo.dart';
import 'package:registro_prestamos/model/client.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/provider/client_provider.dart';
import 'package:registro_prestamos/utils/constants/constants.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/constants/my_colors.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:registro_prestamos/utils/loaders/loaders.dart';
import 'package:registro_prestamos/utils/validators/validation.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({
    super.key,
    required this.clientId,
    required this.name,
    required this.lastname, required this.client,
  });
 
  final ClientModel client;
  final String clientId;
  final String name;
  final String lastname;

  @override
  State<ClientDetails> createState() => _ClientDetailsState();
}

class _ClientDetailsState extends State<ClientDetails> {
  LoanModel? loans;
  final TextEditingController paymentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchLoans();
  }

  Future<void> fetchLoans() async {
    final providerLoan = context.read<ClientProvider>(); 
    final result = await ApiService().getLoanByClientId(widget.clientId);
    providerLoan.setLoan(result!);
  }

  @override
  Widget build(BuildContext context) {
    final loanModel = context.watch<ClientProvider>().loanModel!;
    List<dynamic>? time = loanModel.isNotEmpty() ? loanModel.dueDate?.split('-') : [];
    return Scaffold(
      body: loanModel.isEmpty()
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  PrimaryHeaderContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarWidget(
                          showBackArrow: true,
                          title: Text(
                            'Prestamo del cliente:',
                            style: MyTextStyle.headlineMedium
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Text(
                            '${widget.name[0].toUpperCase()}${widget.name.substring(1)} ${widget.lastname[0].toUpperCase()}${widget.lastname.substring(1)}',
                            style: MyTextStyle.titleLarge,
                          ),
                        ),
                        const SizedBox(height: Dimensions.spaceBtwSections),
                      ],
                    ),
                  ),
                  
                  SizedBox(
                    width: THelperFuntions.screenWidth() > 700 ? 700 : double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                      Column(
                        children: [
                          loanModel.status == Constants.deudaCompletaPagada 
                      
                      ? Column(
                          children: [
                            SizedBox(height: 30),
                            Text(
                              'No tiene deuda pendiente',
                              style: Theme.of(context).textTheme.titleLarge                            ),
                            SizedBox(height: 30),
                            ElevatedButtonWidget(
                              text: 'Crear nuevo prestamo', 
                              onTap: () => Get.to(() => RegistrarPrestamo(
                                isCreate: false,
                                clientId: widget.clientId,
                              ))
                            )
                          ],   
                        )
                      :  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(
                            context,
                            label: 'Deuda Total:',
                            value: formatCurrency(loanModel.totalLoan),
                          ),
                          _buildInfoRow(
                            context,
                            label: 'Fecha limite a pagar el interés:',
                            value: '${time![2]} de ${meses[(int.parse(time[1])-1)]}',
                          ),
                           _buildInfoRow(
                            context,
                            label: 'Estado del pago de interés:',
                            value: loanModel.status.toString(),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            context,
                            label: 'Interés a pagar:',
                            value: formatCurrency(loanModel.interest),
                            buttonLabel: 'Pagar interés',
                            onButtonPressed: () {
                              
                              if(loanModel.status == Constants.pagoCompletado){
                                Loaders.successSnackBar(
                                  title: 'Ya has pagado el interes correspondiente.',
                                  message: 'Para pagar el proximo interés debes esperar despues de esta fecha: ${time[2]} de ${meses[(int.parse(time[1])-1)-1]}'
                                );
                                return;
                              }
                              showPayInterestDialog(context, loanModel);
                            },
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Pagar o Abonar a la deuda:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: paymentController,
                            keyboardType: TextInputType.number,
                            validator: (value) => Validator.validateOnlyNumbers(value),
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Iconsax.direct_right),
                              labelText: 'Monto a abonar',
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Iconsax.money_send),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: loanModel.status != 'pago completado' ? Colors.grey[700] : MyColors.primary, 
                                // foregroundColor: Colors.white, // color del texto e ícono
                              ),
                              onPressed: () {
                                if(loanModel.status.toString() != Constants.pagoCompletado){
                                  Loaders.warningSnackBar(
                                    title: 'Estatus de pago',
                                    message: 'Aun no has pagado el interés correspondiente, primero paga el interés de ${formatCurrency(loanModel.interest)} que tienes pendiente. Luego si puedes pagar o abonar a la deuda.'
                                  );
                                  return;
                                }

                                if (paymentController.text.isEmpty) {
                                  Loaders.errorSnackBar(
                                    title: 'Campo vacío',
                                    message: 'Por favor ingresa una cantidad a abonar.',
                                  );
                                  return;
                                }

                                // Verificar que sea un número válido y mayor a 0
                                double? amount = double.tryParse(paymentController.text);
                                if (amount == null || amount <= 0) {
                                  Loaders.errorSnackBar(
                                    title: 'Cantidad inválida',
                                    message: 'Por favor ingresa una cantidad válida mayor a 0.',
                                  );
                                  return;
                                }
                                showPayAmountDialog(context, loanModel, double.parse(paymentController.text));

                             },
                              label: const Text('Pagar deuda'),
                            ),
                          ),

                          ///pagar el 10 % antes de los 15 dias 
                          const SizedBox(height: 30),
                          loanModel.interest10 
                            ? Column(
                            children: [
                              Text(
                                'Pagar toda tu deuda con 10% de interés:',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                '*Solo aplica a los primeros 15 dias de tener la deuda.',
                                style: Theme.of(context).textTheme.labelSmall!.apply(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: TextEditingController(text: formatCurrency(loanModel.totalLoan + loanModel.totalLoan * 0.1).toString()),
                                keyboardType: TextInputType.number,
                                validator: (value) => Validator.validateOnlyNumbers(value),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.direct_right),
                                  labelText: 'Monto a pagar',
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  icon: const Icon(Iconsax.money_send),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.primary, 
                                    // foregroundColor: Colors.white, // color del texto e ícono
                                  ),
                                  onPressed: () {
                                    showPayFullDialog(context, loanModel);

                                },
                                  label: const Text('Pagar deuda'),
                                ),
                              ),
                            ],
                          ): SizedBox.shrink(),
                          
                        ],
                      ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: THelperFuntions.screenWidth() > 350 ? 350 : double.infinity,
                            child: ElevatedButton(
                              onPressed: (){
                                print('______________historial de pago_________________');
                                print(loanModel.history);
                                print('______________fin_________________');
                                Get.to(() => LoanHistoryClientScreen(
                                  historyList: loanModel.history,
                                  client: widget.client,
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
                      )     
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  
  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
    String? buttonLabel,
    VoidCallback? onButtonPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        if (buttonLabel != null && onButtonPressed != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ElevatedButton(
              onPressed: onButtonPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(buttonLabel),
              ),
            ),
          ),
      ],
    );
  }
}
