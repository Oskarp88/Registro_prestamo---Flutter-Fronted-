
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/button/elevated_button_widget.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/accounts_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_create_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_list_screen.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticateProvider>().user!;

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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Capital:',
                                  style: MyTextStyle.titleLarge,
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 5
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text(
                                    formatCurrency(10000000).toString(),
                                    style: MyTextStyle.bodyLarge,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        '${user.name} ${user.lastname}',
                        style: MyTextStyle.titleMedium,
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

