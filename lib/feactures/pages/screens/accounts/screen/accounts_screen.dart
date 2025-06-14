import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:registro_prestamos/common/styles/my_text_style.dart';
import 'package:registro_prestamos/common/widgets/appbar/appbar.dart';
import 'package:registro_prestamos/common/widgets/custom_shapes/container/primary_headers_container.dart';
import 'package:registro_prestamos/common/widgets/texts/section_headig.dart';
import 'package:registro_prestamos/data/services/api_service.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/interes_accounts_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/accounts/screen/loans_accounts_screen.dart';
import 'package:registro_prestamos/feactures/pages/screens/clients/dialog/show_update_capital.dart';
import 'package:registro_prestamos/feactures/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:registro_prestamos/model/loan.dart';
import 'package:registro_prestamos/provider/auth_provider.dart';
import 'package:registro_prestamos/utils/constants/dimensions.dart';
import 'package:registro_prestamos/utils/helpers/helper_funtions.dart';
import 'package:registro_prestamos/utils/helpers/methods.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({super.key});

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool _isLoading = true;
  bool _isLoadingInterest = true;
  List<LoanModel> loanModel = [];

  @override
  void initState() {
    super.initState();
    _loadCapital();
    _loadInterest();
  }

  Future<void> _loadCapital() async {
    try {
      await ApiService().fetchCapital();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando capital: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
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
                        Text(
                          'Mis Cuentas', 
                          style: MyTextStyle.headlineMedium, 
                        ),
                      ],
                    ),
                  ),                
                  const SizedBox(height: Dimensions.spaceBtwSections,),                      
                ],
              ),
            ),
          ),
          SizedBox(
            width: THelperFuntions.screenWidth() > 700 ? 700 : double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.defaultSpace),
              child: _isLoading && capitalModel.isEmpty()
                ? const Center(child: CircularProgressIndicator())              
                :  Column(
                    children: [
                      const SectionHeading(
                        title: 'Información de tu capital',
                        showActionButton: false,
                      ),
                      const SizedBox(height: Dimensions.spaceBtwItems),
                      ProfileMenu(
                        onPressed: ()=> showUpdateCapitalDialog(context),
                        title: 'Capital disponible',
                        value: formatCurrency(capitalModel.capital),
                      ),
                      const SizedBox(height: Dimensions.spaceBtwItems),
                      ProfileMenu(
                        onPressed: ()=> Get.to(() => InteresAccountsScreen(loanModel: loanModel)),
                        title: 'Total interés por cobrar',
                        value: _isLoadingInterest ? 'cargando...' : formatCurrency(capitalModel.totalInterest),
                      ),
                      const SizedBox(height: Dimensions.spaceBtwItems),
                      ProfileMenu(
                        onPressed: ()=> Get.to(()=>LoansAccountsScreen(loanModel: loanModel)),
                        title: 'Total dinero prestado',
                        value: _isLoadingInterest ? 'cargando...' : formatCurrency(capitalModel.totalLoan),
                      ),
                      const SizedBox(height: Dimensions.spaceBtwItems),
                      ProfileMenu(
                        onPressed: (){},
                        title: 'Total posible capital',
                        value: _isLoadingInterest ? 'cargando...' : formatCurrency(capitalModel.totalLoan+capitalModel.totalInterest+capitalModel.capital),
                      ),
                    ],
                  ),
              ),
          ),
        ],
      ),
    );
  }
  
}