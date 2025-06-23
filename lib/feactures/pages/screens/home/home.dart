import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prestapp/common/styles/my_text_style.dart';
import 'package:prestapp/common/widgets/appbar/appbar.dart';
import 'package:prestapp/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:prestapp/feactures/pages/screens/accounts/screen/accounts_screen.dart';
import 'package:prestapp/feactures/pages/screens/clients/client_create_screen.dart';
import 'package:prestapp/feactures/pages/screens/clients/client_list_screen.dart';
import 'package:prestapp/provider/auth_provider.dart';
import 'package:prestapp/utils/constants/dimensions.dart';
import 'package:prestapp/utils/constants/my_colors.dart';
import 'package:prestapp/utils/helpers/helper_funtions.dart';
import 'package:prestapp/utils/helpers/methods.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticateProvider>();
    final user = authProvider.user!;
    final capitalModel = authProvider.capital!;

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
                      title: Text('Hola,', style: MyTextStyle.headlineMedium),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name} ${user.lastname}',
                            style: MyTextStyle.titleLarge.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 30),

                          Text('Resumen financiero', style: MyTextStyle.titleMedium),
                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Column(
                              children: [
                                _infoRow(Iconsax.wallet, 'Capital disponible:', formatCurrency(capitalModel.capital)),
                                const SizedBox(height: 10),
                                _infoRow(Iconsax.trend_up, 'Ganancias acumuladas:', formatCurrency(capitalModel.ganancias)),
                              ],
                            ),
                          ),

                          const SizedBox(height: Dimensions.spaceBtwSections),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: SizedBox(
                width: THelperFuntions.screenWidth() > 600 ? 600 : double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.defaultSpace, vertical: 40),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _actionButton(
                            context,
                            icon: Iconsax.user_add,
                            text: 'Agregar Cliente',
                            onPressed: () => Get.to(() => ClientCreateScreen()),
                          ),
                          const SizedBox(height: 16),
                          _actionButton(
                            context,
                            icon: Iconsax.people,
                            text: 'Ver todos los clientes',
                            onPressed: () => Get.to(() => ClientListScreen()),
                          ),
                          const SizedBox(height: 16),
                          _actionButton(
                            context,
                            icon: Iconsax.bank,
                            text: 'Tus Cuentas',
                            onPressed: () => Get.to(() => AccountsScreen()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget para mostrar cada fila de info financiera
  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.white24),
        const SizedBox(width: 10),
        Expanded(child: Text(label, style: MyTextStyle.bodyLarge)),
        Text(value, style: MyTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// Botón con icono estilizado
  Widget _actionButton(BuildContext context, {required IconData icon, required String text, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: MyColors.greebAccentDark8,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: Colors.white,),
                SizedBox(width: 20,),
                Text(text, style: MyTextStyle.bodyLarge,),
              ],
            ),
          ),
        )         
      ),
    );
  }
}
