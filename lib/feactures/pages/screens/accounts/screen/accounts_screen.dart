import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/common/widgets/texts/section_headig.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/ganancias_history_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/interes_accounts_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/loans_accounts_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/transaction_history_screen.dart';
import 'package:registro_prestamos/feactures/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';
import 'package:shimmer/shimmer.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool _isLoadingInterest = true;
  List<LoanModel> loanModel = [];

  @override
  void initState() {
    super.initState();
    _loadInterest();
  }


  Future<void> _loadInterest() async {
    try {
      final result = await ApiService().fetchInterest();
      setState(() {
        if(result.isNotEmpty){
          loanModel = result;
          _isLoadingInterest = false;
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando interés: $e');
      }
      setState(() {
        _isLoadingInterest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final capitalModel = context.watch<AuthenticateProvider>().capital!;
    return Scaffold(
      body: Column(
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
                    showBackArrow: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mis Cuentas', style: MyTextStyle.headlineMedium),
                      ],
                    ),
                  ),
                
                  const SizedBox(height: Dimensions.spaceBtwSections,),                      
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.defaultSpace),
                child: capitalModel.isEmpty()
                  ? const Center(child: CircularProgressIndicator())              
                  : Center(
                    child: SizedBox(
                      width: THelperFuntions.screenWidth() > 700 ? 700 : double.infinity,
                      child: Column(
                          children: [
                            const SectionHeading(
                              title: 'Información de tu capital',
                              showActionButton: false,
                            ),
                            const SizedBox(height: Dimensions.spaceBtwItems),
                            ProfileMenu(
                              onPressed: ()=> Get.to(() => TransactionHistoryScreen()),
                              leading: Icons.monetization_on,
                              title: 'Capital disponible',
                              value: Text(formatCurrency(capitalModel.capital)),
                            ),
                            const SizedBox(height: Dimensions.spaceBtwItems),
                            ProfileMenu(
                              onPressed: ()=> Get.to(() => InteresAccountsScreen(loanModel: loanModel)),
                              leading: Icons.monetization_on,
                              title: 'Total interés por cobrar',
                              value: _isLoadingInterest 
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 20,
                                      width: 100, // no lo pongas en infinity aquí porque puede romper layout
                                      decoration: BoxDecoration(
                                        color: Colors.white, // importante: que sea blanco o un gris claro
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                : Text(formatCurrency(capitalModel.totalInterest)),
                            ),
                            const SizedBox(height: Dimensions.spaceBtwItems),
                           ProfileMenu(
                            onPressed: () => Get.to(() => LoansAccountsScreen()),
                            leading: Icons.monetization_on,
                            title: 'Total dinero prestado',
                            value: _isLoadingInterest
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 20,
                                      width: 100, // no lo pongas en infinity aquí porque puede romper layout
                                      decoration: BoxDecoration(
                                        color: Colors.white, // importante: que sea blanco o un gris claro
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                : Text(formatCurrency(capitalModel.totalLoan)),
                          ),
                      
                            const SizedBox(height: Dimensions.spaceBtwItems),
                            ProfileMenu(
                              onPressed: ()=> Get.to(()=>GananciasHistoryScreen()),
                              leading: Icons.monetization_on,
                              title: 'Tus Ganancias',
                              value: _isLoadingInterest 
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 20,
                                      width: 100, // no lo pongas en infinity aquí porque puede romper layout
                                      decoration: BoxDecoration(
                                        color: Colors.white, // importante: que sea blanco o un gris claro
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                : Text(formatCurrency(capitalModel.ganancias)),
                            ),
                            const SizedBox(height: Dimensions.spaceBtwItems),
                            ProfileMenu(
                              onPressed: (){},
                              leading: Icons.monetization_on,
                              title: 'Total posible capital',
                              value: _isLoadingInterest 
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 20,
                                      width: 100, // no lo pongas en infinity aquí porque puede romper layout
                                      decoration: BoxDecoration(
                                        color: Colors.white, // importante: que sea blanco o un gris claro
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                : Text(formatCurrency(capitalModel.totalLoan+capitalModel.totalInterest+capitalModel.capital)),
                            ),
                            const SizedBox(height: 20),
                      
                            Text(
                              'Distribución de capital',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 20),
                      
                            SizedBox(
                            height: 250,
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: capitalModel.capital.toDouble(),
                                    title: formatCurrency(capitalModel.capital),
                                    radius: 100,
                                    titleStyle: MyTextStyle.labelMedium,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: capitalModel.totalInterest.toDouble(),
                                    title: formatCurrency(capitalModel.totalInterest),
                                    radius: 100,
                                    titleStyle: MyTextStyle.labelMedium,
                                  ),
                                  PieChartSectionData(
                                    color: Colors.orange,
                                    value: capitalModel.totalLoan.toDouble(),
                                    title: formatCurrency(capitalModel.totalLoan),
                                    radius: 100,
                                    titleStyle: MyTextStyle.labelMedium,
                                  ),
                                ],
                                sectionsSpace: 2,
                                centerSpaceRadius: 30,
                              ),
                            ),
                          ),
                                      
                          const SizedBox(height: 20),
                                      
                          /// Leyenda personalizada
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLegendItem(Colors.blue, 'Capital'),
                                _buildLegendItem(Colors.green, 'Interés'),
                                _buildLegendItem(Colors.orange, 'Prestado'),
                              ],
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
    );
  }
  
  Widget _buildLegendItem(Color color, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}
 
}