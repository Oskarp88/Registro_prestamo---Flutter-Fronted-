
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/button/elevated_button_widget.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_create_screen.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/manager/assets_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<AuthenticateProvider>().user!;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryHeaderContainer(             
                child: Column(
                  children: [
                    ///appbar
                    AppBarWidget(
                      title: Text(
                        'Hola,', 
                        style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white), 
                      ),
                    ),
                  
                  Text('${user.name} ${user.lastname}'),
                  const SizedBox(height: Dimensions.spaceBtwSections,),
        
                  ],
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
                      onTap: (){}
                    ),
                    SizedBox(height: 20),
                    ElevatedButtonWidget(
                      text: 'Tus Cuentas', 
                      onTap: (){}
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

