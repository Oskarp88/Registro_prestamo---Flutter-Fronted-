
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/button/elevated_button_widget.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/accounts_screen.dart';
import 'package:prestapp/feactures/pages/screens/clients/client_create_screen.dart';
import 'package:prestapp/feactures/pages/screens/clients/client_list_screen.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/helpers/methods.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticateProvider>();
    final user = authProvider.user!;
    final capitalModel = authProvider.capital!;

    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryHeaderContainer(             
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimensions.defaultSpace),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///appbar
                      AppBarWidget(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hola,', 
                              style: MyTextStyle.headlineMedium, 
                            ),
                          ],
                        ),
                      ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name} ${user.lastname}',
                            style: MyTextStyle.titleMedium,
                          ),
                          SizedBox(height: 5),
                          Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Capital:',
                                    style: MyTextStyle.titleMedium,
                                  ),
                                   Text(
                                    'Ganancias:',
                                    style: MyTextStyle.titleMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                                          const SizedBox(width: 8),
                                          Text(
                                            formatCurrency(capitalModel.capital),
                                            style: MyTextStyle.bodyLarge,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.account_balance_wallet, color: Colors.white, size: 20),
                                          const SizedBox(width: 8),
                                          Text(
                                            formatCurrency(capitalModel.ganancias),
                                            style: MyTextStyle.bodyLarge,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              )
                            ],
                          ),
                    
                        ],
                      ),
                    ),
              
                    const SizedBox(height: Dimensions.spaceBtwSections,),
                          
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.defaultSpace,
                  vertical: 100,
                ),
                child: Column(
                  children: [
                    ElevatedButtonWidget(
                      text: 'Agregar Cliente', 
                      onTap: ()=> Get.to(()=> ClientCreateScreen())
                    ),
                    SizedBox(height: 20),
                    ElevatedButtonWidget(
                      text: 'Ver todos los clientes', 
                      onTap: ()=> Get.to(()=> ClientListScreen())
                    ),
                    SizedBox(height: 20),
                    ElevatedButtonWidget(
                      text: 'Tus Cuentas', 
                      onTap: ()=> Get.to(() => AccountsScreen())
                    )
                  ],
                ),
              ),               
            ],
          ),
        ),
      ),
    );
  }
}

