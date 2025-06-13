import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/dialog/show_pay_interest_dialog.dart';
import 'package:registro_prestamos/model/loan.dart';
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
    required this.lastname,
  });

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
    final result = await ApiService().getLoanByClientId(widget.clientId);
    setState(() {
      loans = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic>? time = loans != null ? loans!.dueDate?.split('-') : [];
    return Scaffold(
      body: loans == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  PrimaryHeaderContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarWidget(
                          title: Text(
                            'CLIENTE',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            '${widget.name} ${widget.lastname}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .apply(color: Colors.white),
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
                          _buildInfoRow(
                            context,
                            label: 'Deuda Total:',
                            value: formatCurrency(loans!.totalLoan),
                          ),
                          _buildInfoRow(
                            context,
                            label: 'Fecha limite a pagar el interés:',
                            value: '${time![2]} de ${meses[(int.parse(time[1])-1)]}',
                          ),
                           _buildInfoRow(
                            context,
                            label: 'Estado del pago de interés:',
                            value: loans!.status.toString(),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            context,
                            label: 'Interés a pagar:',
                            value: formatCurrency(loans!.interest),
                            buttonLabel: 'Pagar interés',
                            onButtonPressed: () {
                              
                              if(loans!.status == Constants.pagoCompletado){
                                Loaders.successSnackBar(
                                  title: 'Ya has pagado el interes correspondiente.',
                                  message: 'Para pagar el proximo interés debes esperar despues de esta fecha: ${time![2]} de ${meses[(int.parse(time[1])-1)-1]}'
                                );
                                return;
                              }
                              showPayInterestDialog(context, loans!, widget.name, widget.lastname);
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
                                backgroundColor: loans!.status != 'pago completado' ? Colors.grey[700] : MyColors.primary, 
                                // foregroundColor: Colors.white, // color del texto e ícono
                              ),
                              onPressed: () {
                                if(loans!.status != 'pago'){
                                  Loaders.warningSnackBar(
                                    title: 'Estatus de pago',
                                    message: 'Aun no has pagado el interés correspondiente, primero paga el interés de ${formatCurrency(loans!.interest)} que tienes pendiente. Luego si puedes pagar o abonar a la deuda.'
                                  );
                                }
                              },
                              label: const Text('Pagar deuda'),
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
