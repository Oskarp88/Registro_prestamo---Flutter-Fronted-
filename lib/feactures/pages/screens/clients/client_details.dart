import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/button/elevated_button_widget.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/data/services/api_service.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/loan_history_client_screen.dart';
import 'package:prestapp/feactures/pages/screens/clients/dialog/show_pay_amount_dialog.dart';
import 'package:prestapp/feactures/pages/screens/clients/dialog/show_pay_full.dart';
import 'package:prestapp/feactures/pages/screens/clients/dialog/show_pay_interest_dialog.dart';
import 'package:prestapp/feactures/pages/screens/clients/registrar_prestamo.dart';
import 'package:prestapp/model/client.dart';
import 'package:prestapp/model/loan.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/provider/client_provider.dart';
import 'package:prestapp/utils/constants/constants.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/helpers/methods.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/validators/validation.dart';
import 'package:provider/provider.dart';

class ClientDetails extends StatefulWidget {
  const ClientDetails({
    super.key,
    required this.clientId,
  });
 
 
  final String clientId;
 

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
    final clientProvider = context.watch<ClientProvider>();
    final loanModel = clientProvider.loanModel!;
    final client = clientProvider.clientModel!;

    final isAdmin = context.read<AuthenticateProvider>().user!.isAdmin;
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
                            'Detalle del préstamo',
                            style: MyTextStyle.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Text(
                            '${client.name[0].toUpperCase()}${client.name.substring(1)} ${client.lastname[0].toUpperCase()}${client.lastname.substring(1)}',
                            style: MyTextStyle.titleLarge.copyWith(fontWeight: FontWeight.w600),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (loanModel.status == Constants.deudaCompletaPagada || loanModel.status == Constants.deudafinalizada)
                            Column(
                              children: [
                                const SizedBox(height: 30),
                                Text(
                                  'El cliente no posee deudas activas.',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 30),
                                if (isAdmin)
                                  ElevatedButtonWidget(
                                    text: 'Crear nuevo préstamo',
                                    onTap: () => Get.to(() => RegistrarPrestamo(
                                      isCreate: false,
                                      clientId: loanModel.clientId,
                                    )),
                                  ),
                              ],
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(
                                  context,
                                  label: 'Deuda Total:',
                                  value: formatCurrency(loanModel.totalLoan),
                                ),
                                _buildInfoRow(
                                  context,
                                  label: 'Fecha límite para pagar el interés:',
                                  value: '${time![2]} de ${meses[(int.parse(time[1]) - 1)]}',
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
                                  buttonLabel: isAdmin ? 'Pagar interés' : null,
                                  onButtonPressed: isAdmin
                                      ? () {
                                          if (loanModel.status == Constants.pagoCompletado) {
                                            Loaders.successSnackBar(
                                              title: 'Interés ya pagado',
                                              message: 'Podrá pagar el próximo interés después del: ${time[2]} de ${meses[(int.parse(time[1]) - 2)]}',
                                            );
                                            return;
                                          }
                                          showPayInterestDialog(context, loanModel);
                                        }
                                      : null,
                                ),
                                const SizedBox(height: 30),
                                if (isAdmin) ...[
                                  Text(
                                    'Abonar al préstamo:',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: paymentController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) => Validator.validateOnlyNumbers(value),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Iconsax.direct_right),
                                      labelText: 'Ingrese el monto a abonar',
                                      hintText: 'Ej: 100000',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      icon: const Icon(Iconsax.money_send),
                                      label: const Text('Realizar abono'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: loanModel.status == Constants.interesPagado
                                            ? MyColors.primary
                                            : Colors.grey[700],
                                      ),
                                      onPressed: () {
                                        if (loanModel.status.toString() != Constants.interesPagado) {
                                          Loaders.warningSnackBar(
                                            title: 'Estado del préstamo',
                                            message: 'Debe saldar el interés pendiente de ${formatCurrency(loanModel.interest)} antes de abonar al capital.',
                                          );
                                          return;
                                        }

                                        if (paymentController.text.isEmpty) {
                                          Loaders.errorSnackBar(
                                            title: 'Campo vacío',
                                            message: 'Por favor ingrese una cantidad a abonar.',
                                          );
                                          return;
                                        }

                                        double? amount = double.tryParse(paymentController.text);
                                        if (amount == null || amount <= 0) {
                                          Loaders.errorSnackBar(
                                            title: 'Cantidad inválida',
                                            message: 'Ingrese un monto válido mayor a 0.',
                                          );
                                          return;
                                        }

                                        showPayAmountDialog(context, loanModel, amount);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                                if (isAdmin && loanModel.interest10)
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pagar toda la deuda con un 10% de interés:',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      Text(
                                        '*Aplica solo durante los primeros 15 días.',
                                        style: Theme.of(context).textTheme.labelSmall!.apply(color: Colors.red),
                                      ),
                                      const SizedBox(height: 8),
                                      TextFormField(
                                        readOnly: true,
                                        controller: TextEditingController(
                                            text: formatCurrency(loanModel.totalLoan * 1.1)),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Iconsax.direct_right),
                                          labelText: 'Monto total a pagar',
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          icon: const Icon(Iconsax.money_send),
                                          label: const Text('Pagar deuda'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColors.primary,
                                          ),
                                          onPressed: () {
                                            showPayFullDialog(context, loanModel);
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),
                              ],
                            ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: THelperFuntions.screenWidth() > 700 ? 700 : double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => LoanHistoryClientScreen(
                                  historyList: loanModel.history,
                                  client: client,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.history, color: Colors.white, size: 26),
                                  SizedBox(width: 10),
                                  Text(
                                    'Ver historial de pagos',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
