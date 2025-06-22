import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/feactures/pages/controllers/capital_controller.dart';
import 'package:prestapp/feactures/pages/screens/accounts/widgets/show_update_capital.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/helpers/methods.dart';
import 'package:prestapp/utils/loaders/loaders.dart';
import 'package:prestapp/utils/validators/validation.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';

class GestionDeFondos extends StatefulWidget {
  const GestionDeFondos({super.key});

  @override
  State<GestionDeFondos> createState() => _GestionDeFondosState();
}

class _GestionDeFondosState extends State<GestionDeFondos> {
 final _depositarFormKey = GlobalKey<FormState>();
  final _capitalToGananciasFormKey = GlobalKey<FormState>();
  final _gananciasToCapitalFormKey = GlobalKey<FormState>();
  final _retiroFormKey = GlobalKey<FormState>();

  final capitalDisponible = 150000.0;
  final ganancias = 35000.0;

  final depositarController = TextEditingController();
  final capitalToGananciasController = TextEditingController();
  final gananciasToCapitalController = TextEditingController();
  final retiroController = TextEditingController();

  @override
  void dispose() {
    depositarController.dispose();
    capitalToGananciasController.dispose();
    gananciasToCapitalController.dispose();
    retiroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final capitalModel = context.watch<AuthenticateProvider>().capital!;
    final maxRetiro =   capitalModel.ganancias;
    final capitalController = Get.find<CapitalController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarWidget(
                      title: Text('Gestión de Fondos', style: MyTextStyle.headlineMedium),
                    ),
                    const SizedBox(height: Dimensions.spaceBtwSections),
                  ],
                ),
              ),
            ),
 
            Padding(
              padding: const EdgeInsets.all(Dimensions.defaultSpace),
              child: SizedBox(
                width: THelperFuntions.screenWidth() > 550 ? 550 : double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Capital Disponible: \$${formatCurrency(capitalModel.capital)}',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    Text('Ganancias: \$${formatCurrency(capitalModel.ganancias)}',
                        style:  Theme.of(context).textTheme.titleLarge),
                
                    const SizedBox(height: Dimensions.spaceBtwSections),
                
                    /// Depositar al Capital
                    Text('Depositar al Capital', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    Form(
                      key: _depositarFormKey,
                      child: TextFormField(
                        controller: depositarController,
                        decoration: const InputDecoration(
                          labelText: 'Monto a depositar',
                          prefixIcon: Icon(Iconsax.wallet_add),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: Validator.validateOnlyNumbers,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    GestureDetector(
                      onTap: () {
                          if (_depositarFormKey.currentState!.validate()) {
                            final valor = double.tryParse(depositarController.text);
                              if (valor != null) {
                                showUpdateCapitalDialog(
                                  context: context, 
                                  title: 'Confirmar Ingreso',
                                  text:  'Estás a punto de ingresar ${formatCurrency(valor)} a tu capital',
                                  onPressed: () {                                    
                                    Navigator.pop(context); 
                                    capitalController.addCapital(capital: valor);                                                             
                                  },
                                );
                                depositarController.text = '';
                              } else {
                                 Loaders.errorSnackBar(title: 'Invalido! Campo vacio.');
                              }                          
                            }
                        },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: MyColors.esmeralda5,
                          borderRadius: BorderRadius.circular(15)
                        ), 
                        child: Text(
                          'Depositar',
                          textAlign: TextAlign.center,
                          style: MyTextStyle.titleMedium,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: Dimensions.spaceBtwSections),
                
                    /// Transferir Capital a Ganancias
                    Text('Transferir desde Capital a Ganancias', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    Form(
                      key: _capitalToGananciasFormKey,
                      child: TextFormField(
                        controller: capitalToGananciasController,
                        decoration: const InputDecoration(
                          labelText: 'Monto a transferir',
                          prefixIcon: Icon(Iconsax.arrow_right_34),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: Validator.validateOnlyNumbers,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    GestureDetector(
                      onTap: () {
                          if (_capitalToGananciasFormKey.currentState!.validate()) {
                             final valor = double.tryParse(capitalToGananciasController.text);
                          if(valor != null){
                              if(valor > capitalModel.capital){
                                Loaders.warningSnackBar(
                                  title: 'Fondos insuficientes', 
                                  message: 'Tus fondos solo es de ${formatCurrency(capitalModel.capital)}',
                                  seconds: 3
                                );
                                return;
                              }
                              showUpdateCapitalDialog(
                                context: context, 
                                title: 'Confirmar transferencia',
                                text:  'Estás a punto de transferir ${formatCurrency(valor)} a ganancias',
                                onPressed: () {
                                  capitalController.transferCapitalToGanancias(amount: valor);
                                  Navigator.pop(context);                           
                                },
                              );
                              capitalToGananciasController.text = '';
                            }else{
                              Loaders.errorSnackBar(title: 'Invalido! Campo vacio.');
                            }
                          }
                        },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: MyColors.esmeralda5,
                          borderRadius: BorderRadius.circular(15)
                        ), 
                        child: Text(
                          'Transferir a Ganancias',
                          textAlign: TextAlign.center,
                          style: MyTextStyle.titleMedium,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: Dimensions.spaceBtwSections),
                
                    /// Transferir Ganancias a Capital
                    Text('Transferir desde Ganancias a Capital', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    Form(
                      key: _gananciasToCapitalFormKey,
                      child: TextFormField(
                        controller: gananciasToCapitalController,
                        decoration: const InputDecoration(
                          labelText: 'Monto a transferir',
                          prefixIcon: Icon(Iconsax.arrow_left_34),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: Validator.validateOnlyNumbers,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    GestureDetector(
                      onTap: () {
                          if (_gananciasToCapitalFormKey.currentState!.validate()) {
                            final valor = double.tryParse(gananciasToCapitalController.text);
                            if(valor == null){
                              Loaders.errorSnackBar(title: 'Invalido! Campo vacio.');
                              return;
                            }
                            if(valor > capitalModel.ganancias){
                               Loaders.warningSnackBar(
                                title: 'Fondos insuficientes', 
                                message: 'Tus ganancias de ${formatCurrency(capitalModel.ganancias)} no alcanzan para transferir ${formatCurrency(double.parse(gananciasToCapitalController.text))}',
                                seconds: 3
                              );
                              return;
                            }
                            showUpdateCapitalDialog(
                              context: context, 
                              title: 'Confirmar transferencia',
                              text:  'Estás a punto de transferir ${formatCurrency(valor)} a tu capital',
                              onPressed: () {
                                capitalController.transferGananciasToCapital(amount: valor);
                                Navigator.pop(context);                           
                              },
                            );
                            gananciasToCapitalController.text = '';
                          }
                        },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: MyColors.esmeralda5,
                          borderRadius: BorderRadius.circular(15)
                        ), 
                        child: Text(
                          'Transferir a Capital',
                          textAlign: TextAlign.center,
                          style: MyTextStyle.titleMedium,
                        ),
                      ),
                    ),
                
                    const SizedBox(height: Dimensions.spaceBtwSections),
                
                    /// Retirar ganancias
                    Text('Retirar Ganancias', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    Text('Cantidad máxima: \$${formatCurrency(maxRetiro)}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    Form(
                      key: _retiroFormKey,
                      child: TextFormField(
                        controller: retiroController,
                        decoration: const InputDecoration(
                          labelText: 'Monto a retirar',
                          prefixIcon: Icon(Iconsax.money_remove),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: Validator.validateOnlyNumbers,
                      ),
                    ),
                    const SizedBox(height: Dimensions.spaceBtwItems),
                    GestureDetector(
                      onTap: () {
                        if (_retiroFormKey.currentState!.validate()) {
                          final valor = double.tryParse(retiroController.text);
                          if(valor == null){
                            Loaders.errorSnackBar(title: 'Campo invalido');
                            return;
                          }
                          if(valor > capitalModel.ganancias){
                              Loaders.warningSnackBar(
                              title: 'Fondos insuficientes', 
                              message: 'Solo tienes \$ ${formatCurrency(capitalModel.ganancias)} para retirar.',
                              seconds: 3
                            );
                            return;
                          }
                          showUpdateCapitalDialog(
                            context: context, 
                            title: 'Confirmar retiro',
                            text:  'Estás a punto de retirar ${formatCurrency(valor)} de tus ganancias',
                            onPressed: () {
                              capitalController.withdrawGanancias(amount: valor);
                              Navigator.pop(context);                           
                            },
                          );
                          retiroController.text = '';
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: MyColors.esmeralda5,
                          borderRadius: BorderRadius.circular(15)
                        ), 
                        child: Text(
                          'Retirar',
                          textAlign: TextAlign.center,
                          style: MyTextStyle.titleMedium,
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
}
