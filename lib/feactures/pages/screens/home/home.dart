
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/button/elevated_button_widget.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_create_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/client_list_screen.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';


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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///appbar
                    AppBarWidget(
                      title: Text(
                        'Hola,', 
                        style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.white), 
                      ),
                    ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text('${user.name} ${user.lastname}'),
                  ),
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
                      onTap: ()=> Get.to(()=> ClientListScreen())
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

